import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/home_page.dart';
import 'package:tripwise/pages/navpages/main_page.dart';
import 'package:tripwise/pages/navpages/plan_page.dart';
import 'package:tripwise/pages/navpages/profile_page.dart';

class PlanReadyPage extends StatefulWidget {
  final String location;
  final DateTimeRange selectedDateRange;
  final String selectedOption;
  final String? travelWithChildren;
  final List<String> selectedActivities;

  const PlanReadyPage({
    Key? key,
    required this.location,
    required this.selectedDateRange,
    required this.selectedOption,
    this.travelWithChildren,
    required this.selectedActivities,
  }) : super(key: key);

  @override
  _PlanReadyPageState createState() => _PlanReadyPageState();
}

class _PlanReadyPageState extends State<PlanReadyPage> {
  List<Map<String, dynamic>> options = [];
  Map<String, dynamic>? selectedPlace;
  bool isSaving = false;
  int _currentIndex = 0; // for bottom navigation

  @override
  void initState() {
    super.initState();
    _findMatchingPlaces();
  }

  Future<void> _findMatchingPlaces() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('PopularPlace').get();
    List<QueryDocumentSnapshot> places = snapshot.docs;
    List<Map<String, dynamic>> matchedPlaces = [];

    for (var place in places) {
      Map<String, dynamic> placeData = place.data() as Map<String, dynamic>;
      if (placeData['Attributes'] != null) {
        List<String> matchedAttributes = [];

        if (widget.selectedActivities.contains('Adventure Sports') &&
            placeData['Attributes']['AdventureSports'] == true) {
          matchedAttributes.add('Adventure Sports');
        }
        // Add similar conditions for other activities...

        if (matchedAttributes.isNotEmpty) {
          matchedPlaces.add({
            'place': placeData,
            'matchCount': matchedAttributes.length,
          });
        }
      }
    }

    matchedPlaces.sort((a, b) => b['matchCount'].compareTo(a['matchCount']));
    setState(() {
      options = matchedPlaces.take(3).toList();
    });
  }

  Future<void> _savePlan() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please log in to save the plan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedPlace == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an option')),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await FirebaseFirestore.instance.collection('Plans').add({
        'userId': user.uid,
        'date': DateTime.now(),
        'name': selectedPlace!['place']['Name'],
        'location': selectedPlace!['place']['Location'],
        'destinationId': selectedPlace!['place']['DestinationID'],
        'selectedOption': widget.selectedOption,
        'travelWithChildren': widget.travelWithChildren,
        'selectedActivities': widget.selectedActivities,
        'selectedDateRange': {
          'start': widget.selectedDateRange.start,
          'end': widget.selectedDateRange.end,
        },
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Plan saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save plan: $e')),
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to the corresponding page
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => homePage(user: FirebaseAuth.instance.currentUser)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanPage()), // Replace with actual plan page
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profilePage(user: FirebaseAuth.instance.currentUser)),
        );
        break;
    }
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(initialIndex: 0, user: FirebaseAuth.instance.currentUser),
      ),
          (route) => false, // Removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Your Plan is Ready!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (options.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      options.length,
                          (index) => _buildOptionButton(
                        'Option ${index + 1}',
                        options[index]['place'],
                      ),
                    ),
                  ),
                )
              else
                const Center(
                  child: Text(
                    'No matches found for your selected activities.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16),
              if (selectedPlace != null)
                _buildPlaceDetails(selectedPlace!['place']),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: isSaving ? null : _savePlan,
                  child: isSaving
                      ? CircularProgressIndicator()
                      : Text('Save This Plan'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToHome, // Navigate to Home on button press
                  child: Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String text, Map<String, dynamic> placeData) {
    bool isSelected = selectedPlace != null && selectedPlace!['place']['Name'] == placeData['Name'];

    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedPlace = {'place': placeData};
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildPlaceDetails(Map<String, dynamic> placeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(placeData['ImageURL']),
        const SizedBox(height: 8),
        Text(placeData['Description']),
        const SizedBox(height: 8),
        Text('Location: ${placeData['Location']}'),
        const SizedBox(height: 8),
        Text('Rating: ${placeData['Ratings']}'),
      ],
    );
  }
}
