import 'product.dart';

class Order {

  Product product;
  int quantity;
  
  bool get isSingle => quantity == 1;
  double get totalPrice => product.price * quantity;

  Order({
    required this.product,
    this.quantity = 1,
  });

  Order.fromJson(Map json):
    product = Product.fromJson(json['product']),
    quantity = json['quantity'].toInt();

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
  };
}