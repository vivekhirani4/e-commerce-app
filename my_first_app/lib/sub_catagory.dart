import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubCatagory extends StatefulWidget {

  final s_name;
  final s_id;
  const SubCatagory({
    super.key,
    required this.s_name,
    required this.s_id});

  @override
  State<SubCatagory> createState() => _SubCatagoryState();
}

class _SubCatagoryState extends State<SubCatagory> {

  Future? myfuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfuture = _fetchCatogoryList();
  }

  var mydata = [];
  Future<List> _fetchCatogoryList() async {

     var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-view-product.php');
    var response = await http.post(url , body: {'sub_category_id': widget.s_id});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String , dynamic> mymap = json.decode(response.body);
    mydata = mymap['product'];

    return mydata;
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
      body: FutureBuilder<dynamic>(
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
                leading: Image.network(snapshot.data[index]['product_image'],
                width: 100,),
                title: Text(snapshot.data[index]['product_name']),
                subtitle: Text(snapshot.data[index]['product_details']),
                trailing: Text(snapshot.data[index]['product_price']),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),),
                  tileColor: Colors.blueAccent.withOpacity(0.2),
                // onTap: () {
                //   var s_name = snapshot.data[index]['sub_category_name'];
                //   var s_id = snapshot.data[index]['sub_category_id'];
                //   Navigator.push(
                //     context, 
                //     MaterialPageRoute(
                //       builder: (context) => SubCatagory(s_name : s_name, s_id : s_id),),);

                // },
              ),
            );
          },
        );
        },
      ),
    );
  }
}