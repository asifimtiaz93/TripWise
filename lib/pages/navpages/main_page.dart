import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/home_page.dart';
import 'package:tripwise/pages/navpages/plan_page.dart';
import 'package:tripwise/pages/navpages/profile_page.dart';
import 'package:tripwise/pages/navpages/search_page.dart';
import 'package:tripwise/pages/navpages/vr_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    homePage(),
    vrPage(),
    searchPage(),
    planPage(),
    profilePage(),
  ];
int currentIndex=0;
  void onTap(int index){
  setState(() {
    currentIndex=index;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black38,
        elevation: 2,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.house_siding_outlined)),
          BottomNavigationBarItem(
              label: 'VR', icon: Icon(Icons.threesixty)),
          BottomNavigationBarItem(
              label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(
              label: 'Plan', icon: Icon(Icons.assistant_outlined)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(Icons.person_outline_outlined)),

        ],
      ),
    );
  }
}
