import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../models/models.dart';

part 'cart_state.dart';

class CartModel extends StateNotifier<CartState> {
  CartModel() : super(CartState()) {
    init();
  }

  Future<void> init() async {
    await _restore();
  }

  void addToCart(Product product) {
    state = state.add(product);
    _save();
  }

  void updateQuantity(Product product, int quantity) {
    state = state.updateQuantity(product, quantity);
    _save();
  }

  void removeFromCart(Product product) {
    state = state.remove(product);
    _save();
  }

  @override
  void dispose() {
    state = state.reset();
    super.dispose();
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

        state = state.copyWith(ids: newIds, items: newItems, key: Uuid().v1());
      }
    }
  }
}