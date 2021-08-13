import 'package:get/get.dart';

import '../bindings/bindings.dart';
import '../view/cart.dart';
import '../view/home.dart';
import '../view/product_detail.dart';

final List<GetPage> routes = [
  GetPage(name: '/', page: () => Home(), binding: HomeBindings()),
  GetPage(name: '/cart', page: () => Cart(Get.find())),
  GetPage(name: '/product/:id', page: () => ProductDetail(Get.find())),
];
