import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var photos = [
    "https://akashsir.in/myapi/ecom1/upload/1651269307jeans.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651268981shirt1.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651269296sports1.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651269274highs1.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651269222saree1.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651269098earrings3.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651256751watch1.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651294453dress1.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651645441purse3.jpg",
    "https://akashsir.in/myapi/ecom1/upload/1651646069sling1.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFfafafc),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.shopping_bag_outlined, color: Color(0xFF545D68)),
                    Row(
                      children: [
                        Icon(Icons.search, color: Color(0xFF545D68)),
                        SizedBox(
                          height: 20,
                        ),
                        Icon(Icons.notifications_none, color: Color(0xFF545D68))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: const Text(
                        'Popular Items',
                        style: TextStyle(fontSize: 30),
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 180,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: -75,
                    right: 0,
                    child: Container(
                      height: 180,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.6),
                        itemCount: photos.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: 180,
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                  photos[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
