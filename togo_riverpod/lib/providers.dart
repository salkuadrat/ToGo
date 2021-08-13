import 'package:riverpod/riverpod.dart';
import 'riverpod/riverpod.dart';

final cartProvider = StateNotifierProvider<CartModel, CartState>(
  (ref) => CartModel(),
);

final productsProvider = StateNotifierProvider<ProductsModel, ProductsState>(
  (ref) => ProductsModel(),
);