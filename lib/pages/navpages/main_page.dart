import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/home_page.dart';
import 'package:tripwise/pages/navpages/plan_page.dart';
import 'package:tripwise/pages/navpages/profile_page.dart';
import 'package:tripwise/pages/navpages/search_page.dart';
import 'package:tripwise/pages/navpages/signin.dart';
import 'package:tripwise/pages/navpages/vr_page.dart';
import 'package:tripwise/pages/navpages/popular_places.dart';
import 'package:tripwise/pages/navpages/booking_page.dart';
import 'package:tripwise/pages/navpages/onboard_info_1.dart';
import 'package:tripwise/pages/navpages/settings_page.dart';
import 'package:tripwise/pages/navpages/onboard_info_3.dart';
import 'package:tripwise/pages/navpages/onboard_info_2.dart';

import 'admin_page.dart';
import 'booking_history.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  final User? user;

  const MainPage({Key? key, this.initialIndex = 0, this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int selectedIndex;
  bool isAdmin = false; // To track if the user is admin based on name
  final Set<String> selectedPlaces = {};
  String relationshipStatus = '';

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    _checkIfAdmin(); // Check if the user is "admin"
  }

  Future<void> _checkIfAdmin() async {
    if (widget.user != null) {
      // Check displayName in FirebaseAuth
      print("Checking displayName in FirebaseAuth...");
      print("User displayName: ${widget.user!.displayName}");

      if (widget.user!.displayName == "admin") {
        print("User is admin (displayName match)");
        setState(() {
          isAdmin = true;
        });
      } else {
        // Fetch the name from Firestore
        print("Checking Firestore for user data...");
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('User')
            .doc(widget.user!.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
          print("Firestore user data: $userData");

          // Trim whitespace before comparing
          if (userData != null && userData['Name'].trim() == "admin") {
            print("User is admin (Firestore match)");
            setState(() {
              isAdmin = true; // Set admin flag to true if the name is "admin"
            });
          } else {
            print("User is not admin (Firestore data does not match)");
          }
        } else {
          print("No user data found in Firestore.");
        }
      }
    } else {
      print("No user is logged in.");
    }
  }


  late List<Widget> pages = [
    homePage(user: widget.user),
    vrPage(),
    SearchPage(),
    PlanPage(),
    profilePage(user: widget.user),
    PopularPlacesPage(),
    BookingPage(),
    SignInPage(),
    AdminPage(), // Admin page (conditionally shown)
    OnboardInfoFillup1(),
    SettingsPage(),
    OnboardInfoFillup2(selectedPlaces: selectedPlaces),
    OnboardInfoFillup3(selectedPlaces: selectedPlaces, relationshipStatus: relationshipStatus),
    BookingHistoryPage(),
  ];

  final Map<int, int> bottomNavBarPageMapping = {
    0: 0, // Home
    1: 1, // VR
    2: 2, // Search
    3: 3, // Plan
    4: 4, // Profile
  };

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
        backgroundColor: Colors.white, // Set the app bar background to white
        elevation: 0, // Remove shadow
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Add your logo here
              height: 80,
              width: 80,
            ),
            SizedBox(width: 0), // Add some spacing between logo and text
            Text(
              'TripWise',
              style: TextStyle(
                color: Colors.black, // Set the text color to black
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
              leading: Icon(Icons.video_collection),
              title: Text('Discover'),
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
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Sign In'),
              onTap: () => onDrawerTapped(7),
            ),
            if (isAdmin) // Show Admin option if the user is "admin"
              ListTile(
                leading: Icon(Icons.admin_panel_settings_sharp),
                title: Text('Admin'),
                onTap: () => onDrawerTapped(8),
              ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings_sharp),
              title: Text('Booking History'),
              onTap: () => onDrawerTapped(13),
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // Set bottom nav background to white
        currentIndex: bottomNavBarPageMapping.entries
            .firstWhere((entry) => entry.value == selectedIndex, orElse: () => const MapEntry(0, 0))
            .key,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        elevation: 2,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onBottomNavTapped,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Discover', icon: Icon(Icons.video_collection)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: 'Plan', icon: Icon(Icons.assistant_outlined)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person_outline_outlined)),
        ],
      ),
    );
  }
}
