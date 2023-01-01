import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderList extends StatefulWidget {

  final user_id;

  const OrderList({
    super.key,
    required this.user_id
    });

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}