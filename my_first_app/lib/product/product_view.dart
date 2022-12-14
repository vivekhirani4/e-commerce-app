import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'prodect_details.dart';

class Product_view extends StatefulWidget {
  const Product_view({super.key});

  @override
  State<Product_view> createState() => _Product_viewState();
}

class _Product_viewState extends State<Product_view> {
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
    var response = await http.get(url);
    print('Status code = ${response.statusCode}');
    print('response body = ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    mylist = mymap['product'];

    return mylist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'List of products',
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: myfuture,
              builder: (context, snapshot) {
               return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    tileColor: Colors.blue.withOpacity(0.2),
                    leading: Image.network(
                      snapshot.data[index]['product_image'],
                      width: 50,
                    ),
                    title: Text(snapshot.data[index]['product_name']),
                    subtitle: Text(snapshot.data[index]['sub_category_name']),
                    trailing: Text('\$${snapshot.data[index]['product_price']}'),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),),
                    onTap: () {
                      var product_name = snapshot.data[index]['product_name'];
                      var sub_category_name = snapshot.data[index]['sub_category_name'];
                      var product_price = snapshot.data[index]['product_price'];
                      var image = snapshot.data[index]['product_image'];
                      var details = snapshot.data[index]['product_details'];
                      var p_id = snapshot.data[index]['product_id'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            name : product_name,
                            sub_name : sub_category_name,
                            price: product_price,
                            image: image,
                            details : details,
                            p_id: p_id,
                            ),
                        ),
                      );
                    },
                  ),);
                },
              );
              },
            ),
          ),
        ],
      ),
    );
  }
}
