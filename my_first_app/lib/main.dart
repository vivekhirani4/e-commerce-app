import 'package:flutter/material.dart';
import 'package:my_first_app/cart.dart';
import 'package:my_first_app/catagory.dart';
import 'package:my_first_app/catagory_list.dart';
import 'package:my_first_app/login.dart';
import 'package:my_first_app/registration.dart';
import 'package:my_first_app/splash_screen.dart';

import 'home.dart';
import 'product_view.dart';

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
