import 'package:hive_flutter/hive_flutter.dart';

import 'models/models.dart';

List<int> cartIds = [];
List<Order> cartItems = [];
List<Function?> cartListeners = [];

bool get isEmpty => total == 0;
bool get notEmpty => total > 0;

int get total {
  int total = 0;

  for (var item in cartItems) {
    total += item.quantity;
  }

  return total;
}

double get totalPrice {
  double totalPrice = 0;

  for (var item in cartItems) {
    totalPrice += item.totalPrice;
  }

  return totalPrice;
}

int count(Product product) {
  final id = product.id;

  if (cartIds.contains(id)) {
    final index = cartIds.indexOf(id);
    final item = cartItems.elementAt(index);
    return item.quantity;
  }

  return 0;
}

bool isInCart(Product product) {
  return count(product) > 0;
}

Order item(int index) => cartItems[index];

void addToCart(Product product) {
  cartIds.add(product.id);
  cartItems.add(Order(product: product));
  notifyListeners();
  save();
}

void updateQuantity(Product product, int quantity) {
  final id = product.id;

  if (cartIds.contains(id)) {
    final index = cartIds.indexOf(id);
    final item = cartItems.elementAt(index);
    item.quantity = quantity;
    notifyListeners();
    save();
  }
}

void removeFromCart(Product product) {
  final id = product.id;

  if (cartIds.contains(id)) {
    final index = cartIds.indexOf(id);
    cartIds.removeAt(index);
    cartItems.removeAt(index);
    notifyListeners();
    save();
  }
}

void addListener(Function listener) {
  cartListeners.add(listener);
}

void notifyListeners() {
  for (var listener in cartListeners) {
    listener?.call();
  }
}

Future<void> save() async {
  final box = await Hive.openBox('cart');
  final items = cartItems.map((item) => item.toJson()).toList();
  
  await box.put('items', items);
}

Future<void> restore() async {
  final box = await Hive.openBox('cart');

  if (box.containsKey('items')) {
    final items = box.get('items');

    if (items is List) {
      cartItems = items.map((item) => Order.fromJson(item)).toList();
      cartIds = cartItems.map((item) => item.product.id).toList();
      notifyListeners();
    }
  }
}
