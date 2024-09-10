import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/home_page.dart';
import 'package:tripwise/pages/navpages/plan_page.dart';
import 'package:tripwise/pages/navpages/reviews_page.dart';
import 'package:tripwise/pages/navpages/profile_page.dart';
import 'package:tripwise/pages/navpages/search_page.dart';
import 'package:tripwise/pages/navpages/vr_page.dart';
import 'package:tripwise/pages/navpages/popular_places.dart';
import 'package:tripwise/pages/navpages/booking_page.dart';

class MainPage extends StatefulWidget {
<<<<<<< Updated upstream
  const MainPage({super.key});
=======
  final int initialIndex;
  final User? user;
  const MainPage({super.key, this.initialIndex = 0, this.user});
>>>>>>> Stashed changes

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
<<<<<<< Updated upstream
  List pages = [
    homePage(),
    vrPage(),
    searchPage(),
    planPage(),
    profilePage(),
    PopularPlacesPage(),
    BookingPage(),
<<<<<<< Updated upstream
=======
    SignInPage(),
    OnboardInfoFillup1(),
    SettingsPage(),
    OnboardInfoFillup2(),
    OnboardInfoFillup3(),

>>>>>>> Stashed changes
=======
  late int selectedIndex;

  final Set<String> selectedPlaces = {};
  String relationshipStatus = '';

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  late List<Widget> pages = [
    homePage(user: widget.user),
    const vrPage(),
    const SearchPage(),
    planPage(),
    profilePage(user: widget.user),
    const PopularPlacesPage(),
    const BookingPage(),
    const SignInPage(),
    const AdminPage(),
    const OnboardInfoFillup1(),
    const SettingsPage(),
    OnboardInfoFillup2(selectedPlaces: selectedPlaces),
    OnboardInfoFillup3(selectedPlaces: selectedPlaces, relationshipStatus: relationshipStatus),
>>>>>>> Stashed changes
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
            const DrawerHeader(
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
<<<<<<< Updated upstream
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
=======
              leading: const Icon(Icons.house_siding_outlined),
              title: const Text('Home'),
              onTap: () => onDrawerTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.video_collection),
              title: const Text('Discover'),
              onTap: () => onDrawerTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () => onDrawerTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.assistant_outlined),
              title: const Text('Plan'),
              onTap: () => onDrawerTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline_outlined),
              title: const Text('Profile'),
              onTap: () => onDrawerTapped(4),
            ),
            ListTile(
              leading: const Icon(Icons.place),
              title: const Text('Popular Places'),
              onTap: () => onDrawerTapped(5),
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Booking'),
              onTap: () => onDrawerTapped(6),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () => onDrawerTapped(7),
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_sharp),
              title: const Text('Admin'),
              onTap: () => onDrawerTapped(8),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
        onTap: onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Discover', icon: Icon(Icons.video_collection)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: 'Plan', icon: Icon(Icons.assistant_outlined)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person_outline_outlined)),
>>>>>>> Stashed changes
        ],
      ),
    );
  }
}