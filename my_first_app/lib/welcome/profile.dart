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
  var myname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myname = _getProfile();
  }

  var mobile;
  var email;
  var gender;
  var addres;

  _getProfile() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    var u_id = await srf.getString('user_id');

    var url =
        Uri.https('akashsir.in', '/myapi/ecom1/api/api-user-profile-list.php');
    var response = await http.post(url, body: {
      'user_id': u_id,
    });
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    var mymap = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        myname = mymap['user_name'];
        mobile = mymap['user_mobile'];
        email = mymap['user_email'];
        addres = mymap['user_address'];
        gender = mymap['user_gender'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 22, 169, 254),
            Color(0xffffffff)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                              
              ),
            ),
            Icon(
              Icons.person,
              size: 200,
            ),
            Text(myname == null ? 'Hey,' : "Hey, \n  $myname")
          ],
        ),
      )),
    );
  }
}
