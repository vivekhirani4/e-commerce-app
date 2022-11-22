import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatogoryList extends StatefulWidget {
  const CatogoryList({super.key});

  @override
  State<CatogoryList> createState() => _CatogoryListState();
}

class _CatogoryListState extends State<CatogoryList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCatogoryList();
  }

  var mydata = [];
  void _fetchCatogoryList() async {

     var url = Uri.https('akashsir.in','/myapi/ecom1/api/sub_category_display.php');
    var response = await http.post(url , body: {'category_id': '1'});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String , dynamic> mymap = json.decode(response.body);
    mydata = mymap['sub_category'];

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('catogory list'),
      ),
      body: ListView.builder(
        itemCount: mydata.length,
        itemBuilder: (context, index) {
          return Card(
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                )
              ],
              ),
          );
        },
    
      ),
    );
  }
}