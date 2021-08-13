import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../cubits/cubits.dart';
import '../widgets/widgets.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductsCubit products;

  @override
  void initState() {
    super.initState();

    products = context.read<ProductsCubit>();
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
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (_, state) {
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
              // User Item
              if (isItem) return ProductItem(state.items[index]);
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
