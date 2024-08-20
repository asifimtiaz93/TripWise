import 'package:flutter/material.dart';

import '../admin/booking.dart';
import '../admin/destination.dart';
import '../admin/food.dart';
import '../admin/hotel.dart';
import '../admin/popularplaces.dart';
import '../admin/review.dart';
import '../admin/transport.dart';
import '../admin/trip.dart';
import '../admin/user.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: ListView(
        children: [
          AdminLinkTile(
            title: 'Manage Users',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageUsersPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Trips',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageTripsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Destinations',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageDestinationsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Reviews',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageReviewsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Popular Places',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManagePopularPlacesPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Bookings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageBookingsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Transportation',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageTransportationPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Food',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageFoodPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Hotels',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageHotelsPage()),
              );
            },
          ),

        ],
      ),
    );
  }
}

class AdminLinkTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AdminLinkTile({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
