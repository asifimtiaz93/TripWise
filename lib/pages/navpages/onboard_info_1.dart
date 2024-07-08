// onboard_info_fillup_1.dart
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'main_page.dart';
import 'onboard_info_2.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardInfoFillup1 extends StatelessWidget {
  const OnboardInfoFillup1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainPage()), // Replace HomePage with your home page widget
                    (Route<dynamic> route) => false,
              );
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Please answer the following questions to personalize your account',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'What type of places do you like to visit?',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildPlaceCard('Mountains', 'assets/mountains.jpg'),
                  _buildPlaceCard('Beaches', 'assets/beaches.jpg'),
                  _buildPlaceCard('Cultural Sites', 'assets/cultural_sites.jpg'),
                  _buildPlaceCard('Adventure Spots', 'assets/adventure_spots.jpg'),
                  _buildPlaceCard('Cities', 'assets/cities.jpg'),
                  _buildPlaceCard('Historical Places', 'assets/historical_places.jpg'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background (button) color
                  foregroundColor: Colors.white, // foreground (text) color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OnboardInfoFillup2()),
                  );
                },
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard(String title, String imagePath) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
