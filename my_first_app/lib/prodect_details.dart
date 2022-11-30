import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {

  final name;
  final price;
  final sub_name;
  final image;
  final details;
  final p_id;

  const ProductDetails({
    super.key,
    required this.name, 
    required this.sub_name,
    required this.price,
    required this.image,
    required this.details,
    required this.p_id
    });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  
  Future? myfuture;

  var mylist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfuture = _fetchProductView();
  }

  Future<List> _fetchProductView() async {
    var url = Uri.https('akashsir.in', '/myapi/ecom1/api/api-view-product.php');
    var response = await http.post(url , body: {'product_id' : widget.p_id});
    print('Status code = ${response.statusCode}');
    print('response body = ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    mylist = mymap['product']['product_id'];

    return mylist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(widget.sub_name,
          style: TextStyle(color: Color(0xFF545D68), fontSize: 24),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Color(0xFF545D68),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(left: 26),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Color(0xFF545D68),
                borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0 , 9)
                  ),
                ],
              ),
              child: Image.network('${widget.image}'),
            ),
            SizedBox(height: 30,),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(' Price = \₹ ${widget.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                ),
                ),

                Text(widget.details,
            style: TextStyle(
              fontSize: 19,
              color: Colors.deepPurpleAccent,
            ),
            ),
              ],
            ),
            
            

            
          ],
        ),
        ),
      )
    );
  }
}