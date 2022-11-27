import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product_view extends StatefulWidget {
  const Product_view({super.key});

  @override
  State<Product_view> createState() => _Product_viewState();
}

class _Product_viewState extends State<Product_view> 
  with SingleTickerProviderStateMixin {

  TabController? _tabController;

  Future? myfuture;

  var mylist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
    myfuture = _fetchProductView();
  }

  Future<List> _fetchProductView () async {
    var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-view-product.php');
    var response = await http.get(url);
    print('Status code = ${response.statusCode}');
    print('response body = ${response.body}');

    Map<String , dynamic> mymap = json.decode(response.body);
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
          style: TextStyle(
            color: Color(0xFF545D68),
            fontSize: 24
          ),
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
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            SizedBox(height: 10,),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xFFC88D67),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 35.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
    
                Tab(
                  child: Text('All',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Shirts',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Jeans',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Sarees',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Shoes',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Ear-Rings',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Western dresses',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('High Heels',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Purses & Bags',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
                Tab(
                  child: Text('Western dresses',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 21.0
                  ),
                ),
                ),
    
              ]
            ),
            FutureBuilder<dynamic>( 
              future: myfuture,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Scaffold(body: Center(child: CircularProgressIndicator(),),);
                }
                if(snapshot.hasData)
                {
                  return Scaffold(body: Center(child: Text('has error'),),);
                }
    
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
    
                    return Card(
                      child: ListTile(
                        leading: Image.network(snapshot.data[index]['product_image']),
                      ),
                    );
                    
                  },);
              },
              )
          ],
        ),
      ),
    
    );
  }
}
