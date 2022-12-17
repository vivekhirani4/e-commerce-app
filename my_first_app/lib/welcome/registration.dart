import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_app/product/catagory.dart';
import 'package:my_first_app/welcome/home.dart';
import 'package:my_first_app/welcome/login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  var massage = ' ';

  var data;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();

  String? gender;

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sing Up!',
                    style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle_outlined),
                        hintText: 'User Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    child: TextField(
                      controller: password,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.admin_panel_settings_rounded),
                          hintText: 'Password',
                          suffix: InkWell(
                            onTap: _passwordView,
                            child : Icon(_isHidden ?
                                    Icons.visibility :
                                    Icons.visibility_off)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                            title: const Text("Male"),
                            value: "male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            }),
                      ),
                      Expanded(
                          child: RadioListTile(
                        title: const Text("Female"),
                        value: "female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: mobile,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        hintText: 'Mobile Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        hintText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 88, 105, 235),
                            Color.fromARGB(255, 68, 65, 147),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(2, 9),
                          )
                        ]),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _signup();
                          });
                        },
                        child: const Text(
                          'Sign Up',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Netflix",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(massage),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _passwordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _signup() async {
    var url = Uri.https('akashsir.in', '/myapi/ecom1/api/api-signup.php');
    var response = await http.post(url, body: {
      'user_name': username.text,
      'user_email': email.text,
      'user_password': password.text,
      'user_gender': gender,
      'user_mobile': mobile.text,
      'user_address': address.text
    });
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    var value = mymap['flag'];

    int flag = int.parse(value);

    if (flag == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }
}
