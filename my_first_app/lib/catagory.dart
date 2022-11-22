 import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'catagory_list.dart';

class Catogory extends StatefulWidget {
  const Catogory({super.key});

  @override
  State<Catogory> createState() => _CatogoryState();
}

class _CatogoryState extends State<Catogory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategory();
  }
  var data = [];

  void _fetchCategory() async {
    var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-view-category.php');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    data = mymap['category'];
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catogory list'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => CatogoryList(
                        ),));
                    },
                    trailing: Image.network(data[index]['category_image']),
                    title: Text(data[index]['category_name']),
                  ),
                );
              },
            ),
        ),
      )
    );
  }
}