import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../state/products_state.dart';
import '../widgets/widgets.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductsState products;

  @override
  void initState() {
    super.initState();

    products = context.read<ProductsState>();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await products.init();
    });
  }

  @override
  void dispose() {
    products.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsState>(
      builder: (_, products, __) {
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
              if (isItem) return ProductItem(products.items[index]);
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
