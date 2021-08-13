import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../view/product_list.dart';
import '../widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToGo BLoC'),
        actions: [
          CartButton(),
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => ProductBloc(),
          child: ProductList(),
        ),
      ),
    );
  }
}