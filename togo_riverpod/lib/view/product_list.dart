import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../widgets/widgets.dart';
import '../providers.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, watch, __) {
        final products = watch(productsProvider.notifier);
        final state = watch(productsProvider);

        if (state.isFailed) {
          return Center(child: Text('Fetching data failed.'));
        }

        if (state.isEmpty) {
          return Center(child: Text('No data.'));
        }

        if (state.isLoadingFirst) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: products.refresh,
          child: ScrollablePositionedList.builder(
            itemScrollController: products.itemScrollController,
            itemPositionsListener: products.itemPositionsListener,
            itemCount: state.count + 1,
            itemBuilder: (_, index) {
              bool isItem = index < state.count;
              bool isLastIndex = index == state.count;
              bool isLoadingMore = isLastIndex && state.isLoadingMore;
              // Product Item
              if (isItem) return ProductItem(state.item(index));
              // Show loading more at the bottom
              if (isLoadingMore) return LoadingMore();
              // Default empty content
              return Container();
            },
          ),
        );
      },
    );
  }
}
