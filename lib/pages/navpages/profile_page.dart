import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
<<<<<<< Updated upstream
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
=======
  final User? user;

  const profilePage({super.key, this.user});

  Future<Map<String, dynamic>?> _fetchUserData() async {
    if (user == null) return null;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(user!.uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
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
                const SizedBox(height: 20),
                //profile picture
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('assets/profile.jpg') as ImageProvider,
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          rewardPoints.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text('Reward Points'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          travelTrips.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text('Travel Trips'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          bucketList.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text('Bucket List'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Preferences'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PreferencesPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark_border),
                  title: const Text('Bookmarked'),
                  onTap: () {
                    // Implement navigation to bookmarked page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Previous Trips'),
                  onTap: () {
                    // Implement navigation to previous trips page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Version'),
                  onTap: () {
                    // Implement navigation to version information page
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
>>>>>>> Stashed changes
  }
}
