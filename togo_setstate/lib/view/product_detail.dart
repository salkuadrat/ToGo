import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/models.dart';
import '../shared.dart';
import '../widgets/widgets.dart';

// Bikin sendiri
class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail(this.product, {Key? key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
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
                      imageUrl: widget.product.image,
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
                          widget.product.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Gap(6),
                        Text(
                          widget.product.description,
                          textAlign: TextAlign.center,
                        ),
                        Gap(12),
                        Text('\$ ${widget.product.price}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(15),
          Builder(
            builder: (_) {
              bool inCart = isInCart(widget.product);

              if (inCart) {
                return QuantityButton(
                  count(widget.product),
                  onChanged: (quantity) {
                    if (quantity > 0) {
                      updateQuantity(widget.product, quantity);
                    } else {
                      removeFromCart(widget.product);
                    }
                  },
                );
              }

              return Container(
                child: ElevatedButton(
                  child: Text('Add To Cart'),
                  onPressed: () => addToCart(widget.product),
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
