import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/cart_state.dart';
import 'quantity_button.dart';

class CartItem extends StatelessWidget {
  final Order item;

  const CartItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title),
                  Gap(6),
                  Text(
                    '\$ ${item.product.price}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Gap(10),
            QuantityButton(
              item.quantity,
              onChanged: (quantity) {
                if (quantity > 0) {
                  cart.updateQuantity(item.product, quantity);
                } else {
                  cart.removeFromCart(item.product);
                }
              },
            ),
            Gap(5),
            IconButton(
              onPressed: () => cart.removeFromCart(item.product),
              icon: Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
