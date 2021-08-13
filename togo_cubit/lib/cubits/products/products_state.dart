part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final int page;
  final bool isEmpty;
  final bool isFailed;
  final bool isLoading;
  final bool hasReachedMax;
  final List<Product> items;

  ProductsState({
    this.page = 1,
    this.isEmpty = false,
    this.isFailed = false,
    this.isLoading = false,
    this.hasReachedMax = false,
    this.items = const [],
  });

  int get count => items.length;
  int get nextPage => page + 1;

  bool get isFirstPage => page == 1;
  bool get isLoadingFirst => isLoading && isFirstPage;
  bool get isLoadingMore => isLoading && page > 1;

  Product item(int index) => items[index];

  ProductsState reset() => copyWith(
        page: 1,
        items: [],
        isLoading: false,
        isEmpty: false,
        isFailed: false,
        hasReachedMax: false,
      );

  ProductsState resetPage() => copyWith(page: 1);
  ProductsState startLoading() => copyWith(isLoading: true);
  ProductsState stopLoading() => copyWith(isLoading: false);
  ProductsState empty() => copyWith(isEmpty: true, isFailed: false);
  ProductsState failed() => copyWith(isFailed: true);
  ProductsState reachedMax() => copyWith(hasReachedMax: true, isFailed: false);

  ProductsState replace(List<Product> items) => copyWith(
        items: items,
        page: 2,
        isEmpty: false,
        isFailed: false,
        hasReachedMax: false,
      );

  ProductsState append(List<Product> items) => copyWith(
        items: [...this.items, ...items],
        page: nextPage,
        isEmpty: false,
        isFailed: false,
        hasReachedMax: false,
      );

  ProductsState copyWith({
    int? page,
    bool? isEmpty,
    bool? isFailed,
    bool? isLoading,
    bool? hasReachedMax,
    List<Product>? items,
  }) {
    return ProductsState(
      page: page ?? this.page,
      isEmpty: isEmpty ?? this.isEmpty,
      isFailed: isFailed ?? this.isFailed,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props =>
      [page, items, isEmpty, isFailed, isLoading, hasReachedMax];
}