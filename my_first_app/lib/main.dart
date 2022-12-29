import 'package:flutter/material.dart';
import 'package:my_first_app/order/cart.dart';
import 'package:my_first_app/product/catagory.dart';
import 'package:my_first_app/product/catagory_list.dart';
import 'package:my_first_app/welcome/dashboard.dart';
import 'package:my_first_app/welcome/login.dart';
import 'package:my_first_app/welcome/registration.dart';
import 'package:my_first_app/welcome/splash_screen.dart';
import 'order/add_order.dart';
import 'welcome/home.dart';
import 'product/product_view.dart';
import 'welcome/profile.dart';

void main()
{ // await
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
