import 'package:flutter/material.dart';
import 'package:my_first_app/welcome/login.dart';

import '../product/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  bool animate = false;

  _navigateToHome() async{
    await Future.delayed(Duration(milliseconds: 3000));
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset('assets/shop.png'),
      ),
    );
  }
}