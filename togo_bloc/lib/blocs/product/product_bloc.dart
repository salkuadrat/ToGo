import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../common/api.dart';
import '../../models/models.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState());

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  void init() {
    add(ProductFetched());
    trigger();
  }

  void scrollToTop() {
    itemScrollController.scrollTo(
      index: 0,
      duration: Duration(milliseconds: 300),
    );
  }

  void trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = state.count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !state.hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        add(ProductFetched());
      }
    });
  }

  Future<void> refresh() async {
    add(ProductRefreshed());
  }

  @override
  Stream<Transition<ProductEvent, ProductState>> transformEvents(
    Stream<ProductEvent> events,
    TransitionFunction<ProductEvent, ProductState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductFetched) {
      yield await _mapFetchedToState(state);
    } else if (event is ProductRefreshed) {
      yield await _mapRefreshedToState(state);
    }
  }

  Future<ProductState> _mapFetchedToState(ProductState state) async {
    if (state.hasReachedMax) {
      return state;
    }

    final items = await Api.products(state.page);

    if (items == null) {
      if (state.status == ProductStatus.initial) {
        return state.failed();
      } else {
        return state;
      }
    }

    if (items.isEmpty) {
      if (state.status == ProductStatus.initial) {
        return state.empty();
      } else {
        return state.reachedMax();
      }
    }

    return state.append(items);
  }

  Future<ProductState> _mapRefreshedToState(ProductState state) async {
    final items = await Api.products(1);

    if (items == null || items.isEmpty) {
      return state;
    }

    return state.replace(items);
  }
}