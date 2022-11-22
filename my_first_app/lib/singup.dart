import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

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
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child:const Text("Sing up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                    ),
                  ),
                ),
      
                const SizedBox(height: 20,),
                    Flexible(
                      child:TextField( 
                        controller: username,
                        decoration: InputDecoration(
                          hintText: "User name",
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      )
                    ),
      
                const SizedBox(height: 15,),
      
                TextField( 
                  controller: email,
                  decoration: InputDecoration(
                  hintText: "Email",
                  contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),

                const SizedBox(height: 10,),

                TextField( 
                 controller: password,
                  decoration: InputDecoration(
                  hintText: "password",
                  contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
      
                const SizedBox(height: 10,),
      
                TextField( 
                 controller: mobile,
                  decoration: InputDecoration(
                  hintText: "mobile",
                  contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
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

                const SizedBox(height: 10,),

                const SizedBox(height: 10,),

                TextField(
                  controller: address,
                   decoration: InputDecoration(
                      hintText: "User name",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                      )
                    ),
                ),
      
                const SizedBox(height: 20,),
      
                
                ElevatedButton(
                  onPressed: () {
                    _savedetails();
                  },
                  child: const Text("Register")
                ),    
              ],
            ),
          ),
        ),
      )
    );
  }

   void _savedetails () async{

    var url = Uri.https('akashsir.in','/myapi/ecom1/api/api-signup.php');
    var response = await http.post(url , body: 
    {'user_name' : username.text , 'user_email' : email.text,
    'user_password' : password.text , 'user_gender' : gender,
    'user_mobile': mobile.text, 'user_address' : address.text});
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

  
  }
}



