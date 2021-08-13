import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductBloc products;

  @override
  void initState() {
    super.initState();
    products = context.read<ProductBloc>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      products.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (_, state) {
        switch (state.status) {
          case ProductStatus.failed:
            return Center(child: Text('Fetching data failed.'));
          case ProductStatus.empty:
            return Center(child: Text('No data.'));
          case ProductStatus.success:
            return RefreshIndicator(
              onRefresh: products.refresh,
              child: ScrollablePositionedList.builder(
                itemScrollController: products.itemScrollController,
                itemPositionsListener: products.itemPositionsListener,
                itemCount: state.count + 1,
                itemBuilder: (_, index) {
                  bool isItem = index < state.count;
                  bool isLastIndex = index == state.count;
                  bool isLoadingMore = isLastIndex && !state.hasReachedMax;
                  // Product Item
                  if (isItem) return ProductItem(state.item(index));
                  // Show loading more at the bottom
                  if (isLoadingMore) return LoadingMore();
                  // Default empty content
                  return Container();
                },
              ),
            );
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
