import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../shared.dart';
import '../view/cart.dart';

class CartButton extends StatefulWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _registerListener();
    });
  }

  // refresh when there are changes in cart
  void _registerListener() {
    addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Badge(
        showBadge: notEmpty,
        badgeColor: Colors.pink,
        position: BadgePosition.topEnd(top: 5, end: 3),
        animationDuration: Duration(milliseconds: 250),
        animationType: BadgeAnimationType.fade,
        badgeContent: Text(
          total.toString(),
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
    );
  }
}
