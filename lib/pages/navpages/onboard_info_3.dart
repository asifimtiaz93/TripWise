import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/services/database_helper.dart';
import 'main_page.dart'; // Import the database helper

class OnboardInfoFillup3 extends StatefulWidget {
  final Set<String> selectedPlaces;
  final String relationshipStatus;

  const OnboardInfoFillup3({super.key, required this.selectedPlaces, required this.relationshipStatus});

  @override
  _OnboardInfoFillup3State createState() => _OnboardInfoFillup3State();
}

class _OnboardInfoFillup3State extends State<OnboardInfoFillup3> {
  final TextEditingController _budgetController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper();

  void _savePreferencesLocally() async {
    try {
      await dbHelper.insertPreference('Mountains', widget.selectedPlaces.contains('Mountains').toString());
      await dbHelper.insertPreference('Beaches', widget.selectedPlaces.contains('Beaches').toString());
      await dbHelper.insertPreference('CulturalSites', widget.selectedPlaces.contains('Cultural Sites').toString());
      await dbHelper.insertPreference('AdventureSports', widget.selectedPlaces.contains('Adventure Sports').toString());
      await dbHelper.insertPreference('Cities', widget.selectedPlaces.contains('Cities').toString());
      await dbHelper.insertPreference('HistoricalPlaces', widget.selectedPlaces.contains('Historical Places').toString());
      await dbHelper.insertPreference('RelationshipStatus', widget.relationshipStatus);
      await dbHelper.insertPreference('TravelBudget', _budgetController.text);

      // Navigate to main page or perform additional actions
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
            (Route<dynamic> route) => false,
      );
    } catch (error) {
      print("Failed to save preferences: $error");
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'What is your estimated travel budget?',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _budgetController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Travel Budget',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: _savePreferencesLocally, // Save preferences locally
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
