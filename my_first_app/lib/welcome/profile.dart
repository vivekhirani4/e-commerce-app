import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../order/order_list.dart';

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
  var u_id;

  _getProfile() async {
    SharedPreferences srf = await SharedPreferences.getInstance();
    u_id = await srf.getString('user_id');

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
              colors: [Color.fromARGB(255, 22, 169, 254), Color(0xffffffff)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          myname == null ? 'Hey' : "Hey, \n   $myname",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.8)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderList(user_id: u_id),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Your orders',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[300],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
