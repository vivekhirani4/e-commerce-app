

import 'package:flutter/material.dart';
import 'package:my_first_app/order/cart.dart';
import 'package:my_first_app/welcome/home.dart';

import 'appDrawer.dart';
import 'profile.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  int currentTab = 0;
  final List<Widget> screen = [
    HomeScreen(),
    Cart(),
    Profile(),
    AppDrawer()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),

        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = HomeScreen();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home,
                    color: currentTab == 0 ?
                            Colors.blue : Colors.grey),
                    Text('Home',
                    style: TextStyle(
                      color: currentTab == 0 ?
                            Colors.blue : Colors.grey
                    ),)
                  ],
                ),
                ),
              Spacer(),

                MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = Cart();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart,
                    color: currentTab == 1 ?
                            Colors.blue : Colors.grey),
                    Text('Cart',
                    style: TextStyle(
                      color: currentTab == 1 ?
                            Colors.blue : Colors.grey
                    ),)
                  ],
                ),
                ),
              Spacer(),

                MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = Profile();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle_rounded,
                    color: currentTab == 2 ?
                            Colors.blue : Colors.grey),
                    Text('Profile',
                    style: TextStyle(
                      color: currentTab == 2 ?
                            Colors.blue : Colors.grey
                    ),)
                  ],
                ),
                ),
                Spacer(),

                MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = AppDrawer();
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_outlined,
                    color: currentTab == 3 ?
                            Colors.blue : Colors.grey),
                    Text('Menu',
                    style: TextStyle(
                      color: currentTab == 3 ?
                            Colors.blue : Colors.grey
                    ),)
                  ],
                ),
                )
            ],
          ),
        ),
      ),
    );
  }
}