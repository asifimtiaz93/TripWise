import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'main_page.dart';

class OnboardInfoFillup3 extends StatefulWidget {
  final Set<String> selectedPlaces;
  final String relationshipStatus;

  const OnboardInfoFillup3({Key? key, required this.selectedPlaces, required this.relationshipStatus}) : super(key: key);

  @override
  _OnboardInfoFillup3State createState() => _OnboardInfoFillup3State();
}

class _OnboardInfoFillup3State extends State<OnboardInfoFillup3> {
  final TextEditingController _budgetController = TextEditingController();

  void _savePreferences() {
    // Assuming you have the user's ID available from Firebase Auth or elsewhere
    String userId = 'user321'; // Replace with actual user ID

    // Create a new document in the Preferences collection with user preferences
    FirebaseFirestore.instance.collection('Preferences').doc(userId).set({
      'UserID': userId,
      'Mountains': widget.selectedPlaces.contains('Mountains'),
      'Beaches': widget.selectedPlaces.contains('Beaches'),
      'Cultural Sites': widget.selectedPlaces.contains('Cultural Sites'),
      'Adventure Sports': widget.selectedPlaces.contains('Adventure Spots'),
      'Cities': widget.selectedPlaces.contains('Cities'),
      'Historical Places': widget.selectedPlaces.contains('Historical Places'),
      'RelationshipStatus': widget.relationshipStatus,
      'TravelBudget': _budgetController.text,
    }).then((value) {
      // Navigate to main page or perform additional actions
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
            (Route<dynamic> route) => false,
      );
    }).catchError((error) {
      print("Failed to create preferences: $error");
      // Handle error as needed
    });
  }

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
                'What is your estimated travel budget?',
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
            TextField(
              controller: _budgetController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Travel Budget',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: _savePreferences, // Save user preferences
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
