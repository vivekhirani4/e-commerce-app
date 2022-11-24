import 'package:flutter/material.dart';
import 'package:my_first_app/login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration( 
          gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFA28), Color(0xFFFF6F00)]
          ),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: 
           SafeArea(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Login to move forword and Make shoping with us,\n Search and Shop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
        
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/welcome.png'),
                      ),
                    ),
                  ),
        
                  SizedBox(
                    height: 30,
                  ),
        
                  Column(
                    children: [
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text("Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                      )
                    ],
                  )
        
                  // Image.asset('assets/welcome.png')
                ],
              ),
            ),
          ),
        ),
    );
  }
}
