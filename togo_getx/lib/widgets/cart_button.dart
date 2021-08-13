import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class CartButton extends StatelessWidget {
  final CartController cart = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Badge(
          showBadge: cart.notEmpty,
          badgeColor: Colors.pink,
          position: BadgePosition.topEnd(top: 5, end: 3),
          animationDuration: Duration(milliseconds: 250),
          animationType: BadgeAnimationType.fade,
          badgeContent: Text(
            cart.total.toString(),
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed('/cart'),
          ),
        ),
      ),
    );
  }
}