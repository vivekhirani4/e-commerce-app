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
  var sub_category_name1 = [
    'Sarees',
    'Jeans',
    'Shirts',
    'Western dresses',
    'Ear-Rings',
    'Medicals',
    'Shoes'
    'Purses & Bags',
    'Sling Bags',
    'Watches',
    'High Heels'
  ];


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
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  tileColor: Colors.blue.withOpacity(0.2),
                  leading: Image.network(
                    mylist[index]['product_image'],
                    width: 50,
                  ),
                  title: Text(mylist[index]['product_name']),
                  subtitle: Text(mylist[index]['sub_category_name']),
                  trailing: Text('\$${mylist[index]['product_price']}'),
                  onTap: () {
                    var product_name = mylist[index]['product_name'];
                    var sub_category_name = mylist[index]['sub_category_name'];
                    var product_price = mylist[index]['product_price'];
                    var image = mylist[index]['product_image'];
                    var details = mylist[index]['product_details'];

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          name : product_name,
                          sub_name : sub_category_name,
                          price: product_price,
                          image: image,
                          details : details
                           ),
                      ),
                    );
                  },
                ),);
              },
            ),
          ),
        ],
      ),
    );
  }
}
