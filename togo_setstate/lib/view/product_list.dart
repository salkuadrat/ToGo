import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../common/api.dart';
import '../models/models.dart';
import '../shared.dart';
import '../widgets/widgets.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int _page = 1;
  List<Product> _items = [];

  bool _isEmpty = false;
  bool _isFailed = false;
  bool _isLoading = false;
  bool _hasReachedMax = false;

  int get _count => _items.length;
  bool get _isFirstPage => _page == 1;
  bool get _isLoadingFirst => _isLoading && _isFirstPage;
  bool get _isLoadingMore => _isLoading && _page > 1;

  ItemScrollController _itemScrollController = ItemScrollController();
  ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _refresh();
      _registerListener();
      _trigger();
    });
  }

  @override
  void dispose() {
    _page = 1;
    _items = [];
    _isEmpty = false;
    _isFailed = false;
    _isLoading = false;
    _hasReachedMax = false;
    super.dispose();
  }

  Future<void> _refresh() async {
    _page = 1;
    _loadPerPage();
  }

  Future<void> _loadPerPage() async {
    if (!_isLoading) {
      _startLoading();

      final items = await Api.products(_page);

      setState(() {
        if (items == null) {
          if (_isFirstPage) {
            _isFailed = true;
          }
        } else {
          if (items.isEmpty) {
            if (_isFirstPage) {
              _isEmpty = true;
            } else {
              _hasReachedMax = true;
            }
          } else {
            // if first page, replace _items with items
            // if loading more, add all items to _items
            _items = _isFirstPage ? items : [..._items, ...items];
            _page = _page + 1;

            _isEmpty = false;
            _hasReachedMax = false;
          }

          _isFailed = false;
        }
      });

      _stopLoading();
    }
  }

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  // refresh when there are changes in cart
  void _registerListener() {
    addListener(() {
      if(mounted) setState(() {});
    });
  }

  void _trigger() {
    _itemPositionsListener.itemPositions.addListener(() {
      final pos = _itemPositionsListener.itemPositions.value;
      final lastIndex = _count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !_hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        _loadPerPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFailed) {
      return Center(child: Text('Fetching data failed.'));
    }

    if (_isEmpty) {
      return Center(child: Text('No data.'));
    }

    if (_isLoadingFirst) {
      return Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        itemPositionsListener: _itemPositionsListener,
        itemCount: _count + 1,
        itemBuilder: (_, index) {
          bool isItem = index < _count;
          bool isLastIndex = index == _count;
          bool isLoadingMore = isLastIndex && _isLoadingMore;
          // User Item
          if (isItem) return ProductItem(_items[index]);
          // Show loading more at the bottom
          if (isLoadingMore) return LoadingMore();
          // Default empty content
          return Container();
        },
      ),
    );
  }
}
