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
  List<Widget> pages = [
    homePage(),
    vrPage(),
    searchPage(),
    planPage(),
    profilePage(),
    PopularPlacesPage(),
    BookingPage(),
  ];

  // Map BottomNavigationBar indices to page indices
  final Map<int, int> bottomNavBarPageMapping = {
    0: 0, // Home
    1: 1, // VR
    2: 2, // Search
    3: 3, // Plan
    4: 4, // Profile
  };

  int selectedIndex = 0;

  void onBottomNavTapped(int index) {
    setState(() {
      selectedIndex = bottomNavBarPageMapping[index]!;
    });
  }

  void onDrawerTapped(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.pop(context); // Close the drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TripWise'),
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
              onTap: () => onDrawerTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.threesixty),
              title: Text('VR'),
              onTap: () => onDrawerTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () => onDrawerTapped(2),
            ),
            ListTile(
              leading: Icon(Icons.assistant_outlined),
              title: Text('Plan'),
              onTap: () => onDrawerTapped(3),
            ),
            ListTile(
              leading: Icon(Icons.person_outline_outlined),
              title: Text('Profile'),
              onTap: () => onDrawerTapped(4),
            ),
            ListTile(
              leading: Icon(Icons.place),
              title: Text('Popular Places'),
              onTap: () => onDrawerTapped(5),
            ),
            ListTile(
              leading: Icon(Icons.book_online),
              title: Text('Booking'),
              onTap: () => onDrawerTapped(6),
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavBarPageMapping.entries
            .firstWhere((entry) => entry.value == selectedIndex, orElse: () => const MapEntry(0, 0))
            .key,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black38,
        elevation: 2,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.house_siding_outlined)),
          BottomNavigationBarItem(label: 'VR', icon: Icon(Icons.threesixty)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(
              label: 'Plan', icon: Icon(Icons.assistant_outlined)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(Icons.person_outline_outlined)),
        ],
      ),
    );
  }
}
