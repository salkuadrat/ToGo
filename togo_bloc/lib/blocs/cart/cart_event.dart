part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAdded extends CartEvent {
  final Product product;

  const CartAdded(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'CartAdded { product: $product }';
}

class CartUpdated extends CartEvent {
  final Product product;
  final int quantity;

  const CartUpdated(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];

  @override
  String toString() => 'CartUpdated { product: $product, quantity: $quantity }';
}

class CartRemoved extends CartEvent {
  final Product product;

  const CartRemoved(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'CartRemoved { product: $product }';
}