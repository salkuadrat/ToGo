part of 'product_bloc.dart';

enum ProductStatus { initial, success, failed, empty }

class ProductState extends Equatable {
  final int page;
  final bool hasReachedMax;
  final List<Product> items;
  final ProductStatus status;

  int get count => items.length;
  int get nextPage => page + 1;
  
  Product item(int index) => items[index];

  ProductState({
    this.page = 1,
    this.items = const [],
    this.hasReachedMax = false,
    this.status = ProductStatus.initial,
  });

  ProductState failed() => copyWith(status: ProductStatus.failed);
  ProductState empty() => copyWith(status: ProductStatus.empty, hasReachedMax: true);
  ProductState reachedMax() => copyWith(hasReachedMax: true);

  ProductState append(List<Product> items) => copyWith(
        status: ProductStatus.success,
        items: [...this.items, ...items],
        page: nextPage,
        hasReachedMax: false,
      );

  ProductState replace(List<Product> items) => copyWith(
        status: ProductStatus.success,
        items: items,
        page: 2,
        hasReachedMax: false,
      );

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? items,
    int? page,
    bool? hasReachedMax,
  }) {
    return ProductState(
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, page, items, hasReachedMax];
}