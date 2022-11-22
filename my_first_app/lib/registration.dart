import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_app/catagory.dart';


class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  var data;
  
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                SizedBox(height: 30,),
                
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    hintText: 'User Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.admin_panel_settings_rounded),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),

                  const SizedBox(height: 10,),
              
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text("Male"),
                        value: "male",
                        groupValue: gender,
                        onChanged: (value){
                          setState(() {
                            gender = value.toString();
                          }
                          );
                        }
                      ),
                    ),

                    Expanded(
                      child: RadioListTile(
                        title: Text("Female"),
                        value: "female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          }
                        );
                        },
                      )
                    )
                  ],
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: mobile,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: address,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                    hintText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () {
                    _signup();
                  },
                   child: Text('Sign up'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signup() async{
    var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-signup.php');
    var response = await http.post(url , body: 
    {'user_name' : username.text , 'user_email' : email.text,
    'user_password' : password.text , 'user_gender' : gender,
    'user_mobile': mobile.text, 'user_address' : address.text});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');
    

    Map<String , dynamic> mymap = json.decode(response.body);
    int flag = mymap['flag'];

    if(flag == 1){
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => Catogory(),)
        );
    }
    
  }

}