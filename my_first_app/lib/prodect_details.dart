import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final name;
  final price;
  final sub_name;
  final image;
  final details;
  final p_id;

  const ProductDetails(
      {super.key,
      required this.name,
      required this.sub_name,
      required this.price,
      required this.image,
      required this.details,
      required this.p_id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            widget.sub_name,
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  // margin: EdgeInsets.only(left),
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
                            offset: Offset(0, 9)),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                          '${widget.image}',
                        ),
                      )),
                  // child:
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 180,
                      child: Text(
                        '${widget.name}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      ' Price = \₹ ${widget.price}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text('Product Details',
                      style: TextStyle(
                        fontSize: 19
                      ),),
                      SizedBox(height: 10,),
                      Text(
                        widget.details,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black.withOpacity(0.6)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0,5)
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                    
                ),
              ],
            ),
          ),
        ),);
  }
}
