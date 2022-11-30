import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'sub_catagory.dart';

// class Get_catogory extends StatelessWidget {
//   const Get_catogory({super.key , required this.c_id});

//   final c_id;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ,
//     );
//   }
// }

class CatogoryList extends StatefulWidget {
  final c_id;
  const CatogoryList({required this.c_id});


  @override
  State<CatogoryList> createState() => _CatogoryListState();
}

class _CatogoryListState extends State<CatogoryList> {

  Future? myfuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfuture = _fetchCatogoryList();
  }

  var mydata = [];
  Future<List> _fetchCatogoryList() async {

     var url = Uri.https('akashsir.in','/myapi/ecom1/api/sub_category_display.php');
    var response = await http.post(url , body: {'category_id': widget.c_id});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String , dynamic> mymap = json.decode(response.body);
    mydata = mymap['sub_category'];

    return mydata;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'List of Catagory',
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
        padding: EdgeInsets.fromLTRB(10 , 0 , 10 , 0),
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
                child: ListTile(
                  leading: Image.network(snapshot.data[index]['sub_category_image'],
                  width: 100,),
                  title: Text(snapshot.data[index]['sub_category_name']),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  tileColor: Colors.blueAccent.withOpacity(0.2),
                  onTap: () {
                    var s_name = snapshot.data[index]['sub_category_name'];
                    var s_id = snapshot.data[index]['sub_category_id'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCatagory(s_name : s_name, s_id : s_id),),);
      
                  },
                ),
              );
            },
          );
          },
        ),
      ),
    );
  }
}