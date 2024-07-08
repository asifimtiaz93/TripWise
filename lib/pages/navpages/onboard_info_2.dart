import 'package:flutter/material.dart';
import 'onboard_info_3.dart';
import 'main_page.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardInfoFillup2 extends StatelessWidget {
  const OnboardInfoFillup2({super.key});

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
                'What is your relationship status?',
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
                  _buildPlaceCard('Single', 'assets/single.PNG'),
                  _buildPlaceCard('In a relationship', 'assets/in a relationship.PNG'),
                  _buildPlaceCard('Married', 'assets/married.jpg'),
                  _buildPlaceCard('Married with kids ', 'assets/married with kids.jpg'),

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
                    MaterialPageRoute(builder: (context) => const OnboardInfoFillup3()),
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
