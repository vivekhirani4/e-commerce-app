import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {

  final name;
  final price;
  final sub_name;
  final image;
  final details;

  const ProductDetails({
    super.key,
    required this.name, 
    required this.sub_name,
    required this.price,
    required this.image,
    required this.details,
    });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(widget.sub_name,
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

      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(left: 26),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Color(0xFF545D68),
                borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0 , 9)
                  ),
                ],
              ),
              child: Image.network('${widget.image}'),
            ),
            SizedBox(height: 30,),
      
            Container(
              child: Text(' Price = \₹ ${widget.price}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green
              ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              alignment: Alignment.center,
              child : Text(widget.details,
              style: TextStyle(
                fontSize: 19,
                color: Colors.deepPurpleAccent,
              ),
              )
            ),

            
          ],
        ),
        ),
      )
    );
  }
}