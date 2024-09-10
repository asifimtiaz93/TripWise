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
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: ListView(
        children: [
          AdminLinkTile(
            title: 'Manage Users',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageUsersPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Trips',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageTripsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Destinations',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageDestinationsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Reviews',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageReviewsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Popular Places',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManagePopularPlacesPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Bookings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageBookingsPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Transportation',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageTransportationPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Food',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageFoodPage()),
              );
            },
          ),
          AdminLinkTile(
            title: 'Manage Hotels',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageHotelsPage()),
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

  const AdminLinkTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
