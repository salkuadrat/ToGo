import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';
import '../view/cart.dart';

class CartButton extends StatelessWidget {
  const CartButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartState>(
      builder: (_, cart, __) => Container(
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Cart()),
            ),
          ),
        ),
      ),
    );
  }
}