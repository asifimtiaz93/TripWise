import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
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
              const SizedBox(height: 20),
              Image.asset(
                'assets/settingsicon.png', // Replace with actual image
                height: 150,
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Notification',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to notification settings
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to account settings
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to privacy policy
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Terms and conditions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Implement navigation to terms and conditions
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
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
