import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controllers/controllers.dart';
import '../widgets/widgets.dart';

class ProductList extends StatelessWidget {
  final ProductListController products;

  const ProductList(this.products, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (products.isFailed) {
          return Center(child: Text('Fetching data failed.'));
        }

        if (products.isEmpty) {
          return Center(child: Text('No data.'));
        }

        if (products.isLoadingFirst) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: products.refresh,
          child: ScrollablePositionedList.builder(
            itemScrollController: products.itemScrollController,
            itemPositionsListener: products.itemPositionsListener,
            itemCount: products.count + 1,
            itemBuilder: (_, index) {
              bool isItem = index < products.count;
              bool isLastIndex = index == products.count;
              bool isLoadingMore = isLastIndex && products.isLoadingMore;

              // User Item
              if (isItem) return ProductItem(products.item(index));
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
