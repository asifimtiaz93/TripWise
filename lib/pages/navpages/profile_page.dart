import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/settings_page.dart';

class profilePage extends StatelessWidget {
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

          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Implement edit profile functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'), // Replace with actual image URL
            ),
            SizedBox(height: 10),
            Text(
              'Wazid',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'islamimwazidul@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '360',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Reward Points'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '238',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Travel Trips'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '473',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Bucket List'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Preferences'),
              onTap: () {
                // Implement navigation to preferences page
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text('Bookmarked'),
              onTap: () {
                // Implement navigation to bookmarked page
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Previous Trips'),
              onTap: () {
                // Implement navigation to previous trips page
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
          ],
        ),
      ),
    );
  }
}
