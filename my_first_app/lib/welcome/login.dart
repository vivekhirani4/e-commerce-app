import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:my_first_app/product/catagory.dart';
import 'package:my_first_app/welcome/dashboard.dart';
import 'package:my_first_app/welcome/home.dart';
import 'package:my_first_app/welcome/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mylist = [];

  void _chekdata() async {
    var url = Uri.https('akashsir.in', 'myapi/ecom1/api/api-login.php');
    var response = await http.post(url,
        body: {'user_email': id.text, 'user_password': password.text});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    var data = json.decode(response.body);
    var value = data['flag'];
    int flag = int.parse(value);

    var u_id = data['user_id'];
    print('user id = ${u_id}');
    var u_name = data['user_name'];
    var u_number = data['user_mobile'];
    var u_address = data['user_address'];

    SharedPreferences srf = await SharedPreferences.getInstance();
    await srf.setString('user_id', u_id);
    await srf.setString('user_name', u_name);
    await srf.setString('user_number', u_number);
    await srf.setString('user_address', u_address );

    setState(() {
      if (flag == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashBoardScreen(),
            ),);
      }
    },);
  }

  bool _isHidden = true;

  void _passwordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _forgotPass() async {
    var url =
        Uri.https('akashsir.in', '/myapi/ecom1/api/api-forgot-password.php');
    var response = await http.post(url, body: {'user_email': id.text});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    print('password will send in your email');
  }

  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: id,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: password,
                            style: TextStyle(),
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                                suffix: InkWell(
                                    onTap: _passwordView,
                                    child: Icon(_isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off),),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _chekdata();
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Registration(),
                                      ));
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                onPressed: () {
                                  _forgotPass();
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff4c505b),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
