import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/home_page.dart';
import 'package:tripwise/pages/navpages/plan_page.dart';
import 'package:tripwise/pages/navpages/profile_page.dart';
import 'package:tripwise/pages/navpages/search_page.dart';
import 'package:tripwise/pages/navpages/vr_page.dart';
import 'package:tripwise/pages/navpages/popular_places.dart';
import 'package:tripwise/pages/navpages/booking_page.dart';

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
    PopularPlacesPage(),
    BookingPage(),
  ];
  int bottomNavIndex = 0;
  int drawerIndex = 0;

  void onBottomNavTap(int index) {
    setState(() {
      bottomNavIndex = index;
    });
  }

  void onDrawerTap(int index) {
    setState(() {
      drawerIndex = index;
      Navigator.pop(context); // Close the drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TripWise'), // You can update the title as needed
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.house_siding_outlined),
              title: Text('Home'),
              onTap: () => onDrawerTap(0),
            ),
            ListTile(
              leading: Icon(Icons.threesixty),
              title: Text('VR'),
              onTap: () => onDrawerTap(1),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () => onDrawerTap(2),
            ),
            ListTile(
              leading: Icon(Icons.assistant_outlined),
              title: Text('Plan'),
              onTap: () => onDrawerTap(3),
            ),
            ListTile(
              leading: Icon(Icons.person_outline_outlined),
              title: Text('Profile'),
              onTap: () => onDrawerTap(4),
            ),
            ListTile(
              leading: Icon(Icons.place),
              title: Text('Popular Places'),
              onTap: () => onDrawerTap(5),
            ),
            ListTile(
              leading: Icon(Icons.book_online),
              title: Text('Booking'),
              onTap: () => onDrawerTap(6),
            ),
          ],
        ),
      ),
      body: pages[drawerIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onBottomNavTap,
        currentIndex: bottomNavIndex,
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