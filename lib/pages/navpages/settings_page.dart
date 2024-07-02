import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/settingsicon.png', // Replace with actual image
                height: 150,
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Notification',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to notification settings
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to account settings
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to privacy policy
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Terms and conditions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to terms and conditions
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Rate Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to rate us
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
