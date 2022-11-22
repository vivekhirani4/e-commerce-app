import 'package:flutter/material.dart';
import 'package:my_first_app/catagory.dart';
import 'package:my_first_app/login.dart';
import 'package:my_first_app/registration.dart';
import 'package:my_first_app/singup.dart';



void main()
{ // await
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Catogory(),
    );
  }
}
