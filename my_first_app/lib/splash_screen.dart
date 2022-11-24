import 'package:flutter/material.dart';
import 'package:my_first_app/login.dart';

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

  _navigateToHome() async{
    await Future.delayed(Duration(milliseconds: 1500));
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Login(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('splash'),
        ),
      ),
    );
  }
}