import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPlace extends StatefulWidget {
  const OrderPlace({super.key});

  @override
  State<OrderPlace> createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 45),
            alignment: Alignment.center,
            child: Text(
              'Place Order',
              style: TextStyle(color: Colors.black,
              fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 45),
            child: Text('Enter the Details',
            ),
          )
        ],
      ),
    ));
  }
}
