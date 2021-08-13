import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/models.dart';

class CartController extends GetxController {
  final _ids = <int>[].obs;
  final _items = <Order>[].obs;

  List<int> get ids => _ids.toList();
  List<Order> get items => _items.toList();

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

    if (_ids.contains(id)) {
      final index = _ids.indexOf(id);
      final item = _items.elementAt(index);
      return item.quantity;
    }

    return 0;
  }

  bool has(Product product) {
    return count(product) > 0;
  }

  Order item(int index) => _items[index];

  @override
  void onInit() async {
    await _restore();
    super.onInit();
  }

  void addToCart(Product product) {
    _ids.add(product.id);
    _items.add(Order(product: product));
    _save();
  }

  void updateQuantity(Product product, int quantity) {
    final id = product.id;

    if (_ids.contains(id)) {
      final index = _ids.indexOf(id);
      final item = _items.elementAt(index);
      item.quantity = quantity;

      _items.removeAt(index);
      _items.insert(index, item);
      _save();
    }
  }

  void removeFromCart(Product product) {
    final id = product.id;

    if (_ids.contains(id)) {
      final index = _ids.indexOf(id);
      _ids.removeAt(index);
      _items.removeAt(index);
      _save();
    }
  }

  Future<void> _save() async {
    final box = await Hive.openBox('cart');

    await box.put('items', _items.map((item) => item.toJson()).toList());
  }

  Future<void> _restore() async {
    final box = await Hive.openBox('cart');

    if (box.containsKey('items')) {
      final items = box.get('items');

      if (items is List) {
        _ids.clear();
        _items.clear();
        _items.addAll(items.map((item) => Order.fromJson(item)).toList());
        _ids.addAll(_items.map((item) => item.product.id).toList());
      }
    }
  }
}