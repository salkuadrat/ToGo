part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<int> ids;
  final List<Order> items;
  final String key;

  CartState({
    this.ids = const [],
    this.items = const [],
    this.key = '',
  });

  bool get isEmpty => total == 0;
  bool get notEmpty => total > 0;

  int get total {
    int total = 0;

    for (var item in items) {
      total += item.quantity;
    }

    return total;
  }

  double get totalPrice {
    double totalPrice = 0;

    for (var item in items) {
      totalPrice += item.totalPrice;
    }

    return totalPrice;
  }

  int count(Product product) {
    final id = product.id;

    if (ids.contains(id)) {
      final index = ids.indexOf(id);
      final item = items.elementAt(index);
      return item.quantity;
    }

    return 0;
  }

  bool has(Product product) {
    return ids.contains(product.id);
  }

  Order item(int index) => items[index];

  CartState reset() => copyWith(ids: [], items: [], key: '');

  CartState add(Product product) => copyWith(
        ids: [...ids, product.id],
        items: [...items, Order(product: product)],
        key: Uuid().v1(),
      );

  CartState updateQuantity(Product product, int quantity) {
    if (has(product)) {
      final index = ids.indexOf(product.id);
      final item = items.elementAt(index);
      item.quantity = quantity;

      items.removeAt(index);
      items.insert(index, item);
    }

    return copyWith(key: Uuid().v1());
  }
  
  CartState remove(Product product) {
    if (has(product)) {
      int index = ids.indexOf(product.id);
      ids.removeAt(index);
      items.removeAt(index);
    }

    return copyWith(key: Uuid().v1());
  }

  CartState copyWith({
    List<int>? ids,
    List<Order>? items,
    String? key,
  }) {
    return CartState(
      ids: ids ?? this.ids,
      items: items ?? this.items,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [ids, items, key];
}