import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';
import '../widgets/widgets.dart';

class Cart extends StatelessWidget {
  const Cart({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartState>(
        builder: (_, cart, __) {
          if (cart.isEmpty) {
            return Center(
              child: Text('Your cart is empty.'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (_, index) => CartItem(cart.item(index)),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price'),
                      Text(
                        '\$ ${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}