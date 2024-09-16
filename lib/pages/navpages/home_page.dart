import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripwise/pages/navpages/place_detail_page.dart';
import 'package:tripwise/pages/navpages/view_all_places.dart';


class homePage extends StatefulWidget {
  final User? user;

  const homePage({Key? key, this.user}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String userName = 'Guest'; // Set default username to "Guest"

  @override
  void initState() {
    super.initState();
    _fetchUserName(); // Fetch user name
  }

  Future<void> _fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          setState(() {
            userName = userData['Name'] ?? 'Guest';
          });
        }
      } else {
        setState(() {
          userName = user.displayName ?? 'Guest';
        });
      }
    } else {
      setState(() {
        userName = 'Guest'; // If no user is logged in, show "Guest"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    userName,
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Explore the',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Beautiful ',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Bangla',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Desh!',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Places',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the View All page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAllPlacesPage(),
                        ),
                      );
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('PopularPlace').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    print('No popular places found.');
                    return Center(child: Text('No popular places found.'));
                  }

                  var places = snapshot.data!.docs.take(6).toList(); // Limit to 6 places
                  print("Total popular places shown: ${places.length}");

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling for the grid
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      var data = places[index].data() as Map<String, dynamic>;
                      return _buildPopularPlaceCard(
                        context,
                        placeId: places[index].id,
                        image: data['ImageURL'],
                        title: data['Name'],
                        location: data['Location'],
                        rating: double.tryParse(data['Ratings'].toString()) ?? 0.0,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularPlaceCard(BuildContext context, {
    required String placeId,
    required String image,
    required String title,
    required String location,
    required double rating,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailPage(placeId: placeId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Colors.black54,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 14),
                        SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
