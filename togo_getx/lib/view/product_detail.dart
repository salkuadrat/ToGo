import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ProductDetail extends StatelessWidget {
  final CartController cart;

  const ProductDetail(this.cart, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          CartButton(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 320,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.white,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      placeholder: (_, __) => Container(),
                      errorWidget: (_, __, ___) => Icon(Icons.error),
                    ),
                  ),
                  Gap(10),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 18,
                    ),
                    child: Column(
                      children: [
                        Text(
                          product.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Gap(6),
                        Text(
                          product.description,
                          textAlign: TextAlign.center,
                        ),
                        Gap(12),
                        Text('\$ ${product.price}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(15),
          Obx(
            () {
              bool inCart = cart.has(product);

              if (inCart) {
                return QuantityButton(
                  cart.count(product),
                  onChanged: (quantity) {
                    if (quantity > 0) {
                      cart.updateQuantity(product, quantity);
                    } else {
                      cart.removeFromCart(product);
                    }
                  },
                );
              }

              return Container(
                child: ElevatedButton(
                  child: Text('Add To Cart'),
                  onPressed: () => cart.addToCart(product),
                ),
              );
            },
          ),
          Gap(18),
        ],
      ),
    );
  }
}