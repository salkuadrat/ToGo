import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';
import '../view/cart.dart';

class CartButton extends StatelessWidget {
  const CartButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (_, state) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Badge(
          showBadge: state.notEmpty,
          badgeColor: Colors.pink,
          position: BadgePosition.topEnd(top: 5, end: 3),
          animationDuration: Duration(milliseconds: 250),
          animationType: BadgeAnimationType.fade,
          badgeContent: Text(
            state.total.toString(),
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