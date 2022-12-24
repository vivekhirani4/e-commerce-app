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
  Future? myfuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     myfuture= _fetchCategory();
  }

  var data = [];
  Future<List> _fetchCategory() async {
    var url =
        Uri.https('akashsir.in', '/myapi/ecom1/api/api-view-category.php');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    data = mymap['category_list'];

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Catagory',
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
        padding: EdgeInsets.all(15),
        child: FutureBuilder<dynamic>(
          future: myfuture,
          builder: (context, snapshot) {
          if(!snapshot.hasData)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError)
          {
            return Center(child: Text('has some error'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    onTap: () {
                      var category_id = snapshot.data[index]['category_id'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CatogoryList(c_id: category_id),
                        ),
                      );
                    },
                    trailing: Image.network(snapshot.data[index]['category_image']),
                    title: Text(snapshot.data[index]['category_name']),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                    tileColor: Colors.blueAccent.withOpacity(0.2),
                  ),
                ),
              );
            },
          );
        }
        ),
      ),
    );
  }
}
