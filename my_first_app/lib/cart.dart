import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Cart',
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
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://akashsir.in/myapi/ecom1/upload/1651269296sports1.jpg'),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Flexible(
                      child: Text(
                        'NIKE ledies shoese for running',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 5,),

                  ],
                ),
                
              ],
            ),
          )),
    );
  }
}
