import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:my_first_app/catagory.dart';
import 'package:my_first_app/registration.dart';
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
    var url = Uri.https('akashsir.in','myapi/ecom1/api/api-login.php');
    var response = await http.post(url, body: {'user_email': id.text,'user_password':password.text});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    var data = json.decode(response.body);
    var flag = data['flag'] as int;
    print('flag = ${flag}');
    var u_id = data['userdata']['user_id'];
    print('user id = ${u_id}');

    SharedPreferences srf = await SharedPreferences.getInstance();
    await srf.setInt('flag' , flag);
    await srf.setString('user_id', u_id);

    setState(() {
      if(flag == 1){
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => Catogory(),
          )
        );
      }
    });

  }

  void _forgotPass() async {
    var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-forgot-password.php');
    var response = await http.post(url , body: {'user_email' : id.text});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

  }

  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('https://cdn-icons-png.flaticon.com/512/5087/5087579.png',
                  height: 60,
                  width: 60,),
                  const SizedBox(width: 10,),

                  GradientText('Login',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                    colors: const [
                      Colors.blue,
                      Colors.pink
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20,),
              TextField(
                controller: id,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  focusColor: Colors.green,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  labelText: 'Enter username',
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  prefixIcon : const Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  labelText: 'Enter password'
                ),
              ),
              const SizedBox(height: 15,),
              
              TextButton(
                onPressed: () {
                  _forgotPass();  
                }, 
                child: Text('Fogot Password')
                ),

              ElevatedButton(
                onPressed: (){
                  _chekdata();
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                 primary: Colors.green
                ),
              ),
              const SizedBox(height: 10,),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Registration(),
                    )
                  );
                },
                 child: Text("don't have an acount"))
            ]
          ),
        )
      ),
    );
  }
}