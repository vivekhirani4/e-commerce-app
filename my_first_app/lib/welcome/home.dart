import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:my_first_app/product/catagory_list.dart';

import '../product/sub_catagory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future? myfuture;
  Future? categoryList;

  var mydata = [];

  var category = [];
  Future<List> _fetchSubCategoryList() async {
    var url =
        Uri.https('akashsir.in', '/myapi/ecom1/api/api-subcategory-list.php');
    var response = await http.get(url);
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    mydata = mymap['sub_category_list'];

    return mydata;

  }

  ScrollController? _scrollController;
  TabController? _tabController;

  Future<List> _fetchCategoryList() async {
    var url =
        Uri.https('akashsir.in', '/myapi/ecom1/api/api-view-category.php');
    var response = await http.get(url);
    print('response code : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<String, dynamic> mymap = json.decode(response.body);
    category = mymap['category_list'];

    return category;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();

    categoryList = _fetchCategoryList();

    myfuture = _fetchSubCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      style: TextStyle(fontSize: 30,),
                    ),)
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 160,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  left: -75,
                  right: 0,
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
                    return Container(
                      height: 140,
                      child: PageView.builder(
                        controller: PageController(
                          viewportFraction: 0.4,
                        ),
                        itemCount: snapshot.data.length,
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
                                  snapshot.data[index]['sub_category_image'],
                                ),
                                fit: BoxFit.fitHeight,
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
                    );
                    },
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.8),
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Category',
              style: TextStyle(

                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<dynamic>(
                future: categoryList,
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
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                        itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var c_id = snapshot.data[index]['category_id'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CatogoryList(
                                c_id: c_id,
                              ),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Expanded(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(snapshot.data[index]['category_image'],
                                  fit: BoxFit.fitHeight,
                                  height: 130,),
                                ),
                                Text(snapshot.data[index]['category_name'],
                                style: TextStyle(
                                  fontSize: 18,
                                ),)
                              ],
                            ),
                          ),
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
    );
  }
}
