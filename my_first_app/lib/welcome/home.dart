import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../product/sub_catagory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  Future? myfuture;

  var mydata = [];
  Future<List> _fetchCatogoryList() async {
    var url =
        Uri.https('akashsir.in', '/myapi/ecom1/api/sub_category_display.php');
    var response = await http.get(url);
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    mydata = mymap['sub_category'];

    return mydata;
  }

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
    "https://akashsir.in/myapi/ecom1/upload/1651646069sling1.jpg",
    "https://t4.ftcdn.net/jpg/02/81/42/77/360_F_281427785_gfahY8bX4VYCGo6jlfO8St38wS9cJQop.jpg"
  ];

  ScrollController? _scrollController;
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();

    myfuture = _fetchCatogoryList();
  }

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
                        controller: PageController(
                          viewportFraction: 0.4,
                        ),
                        itemCount: photos.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: 180,
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                  photos[index],
                                ),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                var s_name = 'vivek';
                                var s_id = (index + 1).toString();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubCatagory(s_name: s_name, s_id: s_id),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 2,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: FutureBuilder<dynamic>(
                  future: myfuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('has some error'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              photos[index],
                              width: 100,
                            ),
                            title:
                                Text(snapshot.data[index]['sub_category_name']),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            tileColor: Colors.blueAccent.withOpacity(0.2),
                            onTap: () {
                              var s_name =
                                  snapshot.data[index]['sub_category_name'];
                              var s_id =
                                  snapshot.data[index]['sub_category_id'];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SubCatagory(s_name: s_name, s_id: s_id),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
