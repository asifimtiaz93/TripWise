import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/preference_page.dart';
import 'package:tripwise/pages/navpages/profile_page_edit.dart';
import 'package:tripwise/pages/navpages/saved_plans.dart';
import 'package:tripwise/pages/navpages/settings_page.dart';
import 'package:tripwise/pages/navpages/signin.dart'; // Import the sign-in page to navigate after logout

class profilePage extends StatelessWidget {
  final User? user;

  const profilePage({Key? key, this.user}) : super(key: key);

  Future<Map<String, dynamic>?> _fetchUserData() async {
    if (user == null) return null;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(user!.uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()), // Navigate to sign-in page
          (Route<dynamic> route) => false, // Clear navigation stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePageEdit(user: user),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found'));
          }

          Map<String, dynamic> userData = snapshot.data!;
          String name = userData['Name'] ?? 'No Name';
          String email = userData['Email'] ?? 'No Email';
          int rewardPoints = userData['RewardPoints'] ?? 0;
          int travelTrips = userData['TravelTrips'] ?? 0;
          int bucketList = userData['BucketList'] ?? 0;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                // Profile picture
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : AssetImage('assets/profile.jpg') as ImageProvider,
                ),

                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),

                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Preferences'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PreferencesPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark_border),
                  title: Text('Booking History'),
                  onTap: () {
                    // Implement navigation to bookmarked page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Saved Plans'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavedPlansPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Version'),
                  onTap: () {
                    // Implement navigation to version information page
                  },
                ),
                SizedBox(height: 20),
                // Logout button
                Center(
                  child: ElevatedButton(
                    onPressed: () => _logout(context), // Call logout function
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
