import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/cart_controller.dart';
import 'routes/routes.dart';

void main() async {
  await Hive.initFlutter();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToGo GetX',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        textTheme: GoogleFonts.sourceSansProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      getPages: routes,
    );
  }
}