import 'package:flutter/material.dart';
import 'package:my_first_app/welcome/dashboard.dart';
import 'package:my_first_app/welcome/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'welcome_page.dart';

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

  _navigateToHome() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    var s_id = await srf.getString('user_id');
		await Future.delayed(Duration(milliseconds: 3000));
    
    if (s_id == null) {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    }
    else{
			Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoardScreen(),
        ),
      );
    }
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
