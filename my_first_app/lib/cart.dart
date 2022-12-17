import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfuture = _fetchCart();
  }

  Future? myfuture;
  var mylist = [];
  var total;

  Future<List> _fetchCart() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    var u_id = srf.getString('user_id');

    var url = Uri.https('akashsir.in', '/myapi/ecom1/api/api-cart-list.php');
    var response = await http.post(url, body: {'user_id': u_id});

    Map<String, dynamic> mymap = json.decode(response.body);

    mylist = mymap['cart'];

    total = mymap['grand_total'];

    return mylist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Cart',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<dynamic>(
                future: myfuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('has some error'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                              snapshot.data[index]['product_image'],
                            ),
                            title: Text(
                              '${snapshot.data[index]['product_name']}',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            subtitle:  Text(
                                  'Qty = ${snapshot.data[index]['product_qty']} \n \n ₹ ${snapshot.data[index]['product_price']}',
                                  style: TextStyle(color: Colors.green),
                                ),
                            trailing: IconButton(
                              onPressed: () async {
                                var cart_id = snapshot.data[index]['cart_id'];
            
                                var url = Uri.https('akashsir.in',
                                    '/myapi/ecom1/api/api-cart-remove-product.php');
                                var response = await http
                                    .post(url, body: {'cart_id': cart_id});
                                    print('response body = ${response.body}');
            
                                print('removed successfully ${snapshot.data[index]['product_name']}');
                              },
                              icon: Icon(Icons.remove_circle_outline_rounded),
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){

              },
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Place order'),
                  Text('Total ${total}')  
                ],
               ))
          ],
        ),
      ),
    );
  }
}
