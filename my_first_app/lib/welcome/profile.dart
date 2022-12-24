import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Future? myfuture;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _getProfile();
  }

  var name;
  var mobile;
  var email;
  var gender;
  var addres;

  void _getProfile() async {


    SharedPreferences srf = await SharedPreferences.getInstance();
    var u_id = await srf.getString('user_id');

    var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-user-profile-list.php');
    var response = await http.post(url , body: {
      'user_id' : u_id,
    });
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');
    
    var mymap = json.decode(response.body);

    name = mymap['user_name'];
    mobile = mymap['7621845339'];
    email = mymap['user_email'];
    addres = mymap['user_address'];
    gender = mymap['user_gender'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'User profile',
                style: TextStyle(fontSize: 24,
                 fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Icon(Icons.person,
          size: 200,),

          Text(name)
        ],
      ),
    ));
  }
}
