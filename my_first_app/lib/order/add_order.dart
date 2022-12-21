import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderPlace extends StatefulWidget {
  final total;
  const OrderPlace({super.key, required this.total});

  @override
  State<OrderPlace> createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  TextEditingController shipping_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();

  var shipping_method;

  void _makeOrder() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    var u_id = await srf.getString('user_id');

    var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-add-order.php');
    var response = await http.post(url , body: {
      'user_id' : u_id,
      'shipping_name': shipping_name.text,
      'shipping_mobile' : mobile.text,
      'shipping_address' : address.text,
      'payment_method' : shipping_method});

      print('response code : ${response.statusCode}');
      print('response body : ${response.body}');

      var mymap = json.decode(response.body);
      
      var flag = mymap['flag'];
      if(flag == '1')
      {
        Fluttertoast.showToast(
          msg: 'Oderd successfully.',
          backgroundColor: Colors.green,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 17,
          textColor: Colors.black
          );
      }
  }

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
                    },
                  ),
                  Text(
                    'Place Order',
                    style: TextStyle(color: Color.fromARGB(255, 232, 112, 19), fontSize: 20),
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
                style: TextStyle(
                  fontSize: 18,
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
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20),
            ),
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
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _makeOrder();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' Make Order',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    '${widget.total} ₹',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 232, 112, 19)
              ),
            )
          ],
        ),
      ),
    ));
  }
}
