import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/cart_state.dart';
import '../view/product_detail.dart';
import 'quantity_button.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetail(product)),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 20,
            right: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Gap(10),
                    Text(
                      product.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(15),
                    Text('\$ ${product.price}'),
                    Gap(24),
                    Consumer<CartState>(
                      builder: (_, cart, __) {
                        if (cart.has(product)) {
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

                        return ElevatedButton(
                          child: Text('Add To Cart'),
                          onPressed: () => cart.addToCart(product),
                        );
                      },
                    ),
                    Gap(20),
                  ],
                ),
              ),
              Gap(15),
              Container(
                width: 120,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: CachedNetworkImage(
                  imageUrl: product.thumb,
                  placeholder: (_, __) => Container(),
                  errorWidget: (_, __, ___) => Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
