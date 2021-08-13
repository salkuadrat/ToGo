import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../models/models.dart';

part 'cart_state.dart';
part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState());

  Future<void> init() async {
    await _restore();
  }

  void addToCart(Product product) {
    add(CartAdded(product));
  }

  void updateQuantity(Product product, int quantity) {
    add(CartUpdated(product, quantity));
  }

  void removeFromCart(Product product) {
    add(CartRemoved(product));
  }

  Future<void> _save() async {
    final box = await Hive.openBox('cart');
    await box.put('items', state.items.map((item) => item.toJson()).toList());
  }

  Future<void> _restore() async {
    final box = await Hive.openBox('cart');

    if (box.containsKey('items')) {
      final items = box.get('items');

      if (items is List) {
        final newItems = items.map((item) => Order.fromJson(item)).toList();
        final newIds = newItems.map((item) => item.product.id).toList();

        emit(state.copyWith(ids: newIds, items: newItems, key: Uuid().v1()));
      }
    }
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartAdded) {
      yield* _mapCartAddedToState(event);
    } else if (event is CartUpdated) {
      yield* _mapCartUpdatedToState(event);
    } else if (event is CartRemoved) {
      yield* _mapCartRemovedToState(event);
    }
  }

  Stream<CartState> _mapCartAddedToState(CartAdded event) async* {
    yield state.add(event.product);
    _save();
  }

  Stream<CartState> _mapCartUpdatedToState(CartUpdated event) async* {
    yield state.updateQuantity(event.product, event.quantity);
    _save();
  }

  Stream<CartState> _mapCartRemovedToState(CartRemoved event) async* {
    yield state.remove(event.product);
    _save();
  }
}