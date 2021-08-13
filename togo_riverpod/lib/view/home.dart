import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'product_list.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToGo Riverpod'),
        actions: [
          CartButton(),
        ],
      ),
      body: SafeArea(
        child: ProductList(),
      ),
    );
  }
}