import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPlace extends StatefulWidget {

  final total;
  const OrderPlace({
  super.key,
  required this.total});

  @override
  State<OrderPlace> createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  TextEditingController shipping_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController method = TextEditingController();

  var shipping_method;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },),
                  Text(
                    'Place Order',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Icon(Icons.notifications_none)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              padding: EdgeInsets.all(9),
              child: Text(
                'Enter the Details',
                style: TextStyle(fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: shipping_name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Shipping Name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: mobile,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Enter Mobile'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: address,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Enter Shpping Adress'),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Select Payment Method',
            style: TextStyle(
              fontSize: 20
            ),),
            SizedBox(
              height: 10,
            ),
            RadioListTile(
                value: 'Case on Delivery',
                title: Text('Case on Delivery'),
                groupValue: shipping_method,
                onChanged: (value) {
                  setState(() {
                    shipping_method = value.toString();
                  });
                }),
            RadioListTile(
              title: Text('UPI/Debit Card/Credit Card'),
              value: 'Online pyment',
              groupValue: shipping_method,
              onChanged: (value) {
                shipping_method = value.toString();
              }),

          ],
        ),
      ),
    ));
  }
}
