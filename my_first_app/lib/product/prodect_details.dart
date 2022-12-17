import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../cart.dart';

class ProductDetails extends StatefulWidget {
  final name;
  final price;
  final sub_name;
  final image;
  final details;
  final p_id;

  const ProductDetails(
      {super.key,
      required this.name,
      required this.sub_name,
      required this.price,
      required this.image,
      required this.details,
      required this.p_id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var u_id;

  
  int count = 1;
  TextEditingController quantity = new TextEditingController();

  void _incrementCount() {
    setState(() {
      count = count + 1;
    });
  }

  void _decreseCount(){
    setState(() {

      if(count>1)
      {
        count = count - 1;
      }
      else{
        count = 1;
      }
      
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _addcart() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    u_id = await srf.getString('user_id');
    var qty = quantity.text;
    print('quantity = ${qty}');
    print('user id = ${u_id}');
      var url =
          Uri.https('akashsir.in', '/myapi/ecom1/api/api-cart-insert.php');
      var response = await http.post(url, body: {
        'user_id': u_id,
        'product_id': widget.p_id,
        'product_qty': '${count}'
      });

      print(response.body);
      Map<String, dynamic> mymap = json.decode(response.body);
      var result = mymap['flag'];
      
      
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Cart(),
          ),
        );

        Fluttertoast.showToast(
            msg: "${widget.name} is added into cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
            );
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.sub_name,
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
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                // margin: EdgeInsets.only(left),
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
                          offset: Offset(0, 9)),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        '${widget.image}',
                      ),
                    )),
                // child:
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    child: Text(
                      '${widget.name}',
                      style: TextStyle(fontSize: 18),
                    ), 
                  ),
                  Text(
                    ' Price = \₹ ${widget.price}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'Product Details',
                      style: TextStyle(fontSize: 19),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.details,
                      style: TextStyle(
                          fontSize: 17, color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  IconButton(onPressed: () {
                    _decreseCount();
                  },
                   icon: Icon(Icons.minimize),),

                  Text('$count' ),

                  IconButton(onPressed: () {
                    _incrementCount();
                  }, icon: Icon(Icons.add))

                ],
              ),
              SizedBox(height: 5,),
              ElevatedButton(
                onPressed: () {
                  _addcart();

                },
                child: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(390, 48),
                    primary: Colors.yellow[600]),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
