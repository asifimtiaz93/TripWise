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
  int _currentIndex = 0;

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
        if (widget.selectedActivities.contains('Beach Relaxation') &&
            placeData['Attributes']['Beaches'] == true) {
          matchedAttributes.add('Beach Relaxation');
        }
        if (widget.selectedActivities.contains('City Exploration') &&
            placeData['Attributes']['Cities'] == true) {
          matchedAttributes.add('City Exploration');
        }
        if (widget.selectedActivities.contains('Cultural Experiences') &&
            placeData['Attributes']['CulturalSites'] == true) {
          matchedAttributes.add('Cultural Experiences');
        }
        if (widget.selectedActivities.contains('Historical Landmarks') &&
            placeData['Attributes']['HistoricalPlaces'] == true) {
          matchedAttributes.add('Historical Landmarks');
        }
        if (widget.selectedActivities.contains('Mountain Hikes') &&
            placeData['Attributes']['Mountains'] == true) {
          matchedAttributes.add('Mountain Hikes');
        }

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
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Your Plan is Ready!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 16),
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
                Center(
                  child: Text(
                    'No matches found for your selected activities.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              SizedBox(height: 16),
              if (selectedPlace != null)
                _buildPlaceDetails(selectedPlace!['place']),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: isSaving ? null : _savePlan,
                  child: isSaving
                      ? CircularProgressIndicator()
                      : Text('Save This Plan'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.lightBlueAccent,
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToHome,
                  child: Text('Back to Home'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildOptionButton(String text, Map<String, dynamic> placeData) {
    bool isSelected = selectedPlace != null && selectedPlace!['place']['Name'] == placeData['Name'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedPlace = {'place': placeData};
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blueAccent : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.blueAccent),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildPlaceDetails(Map<String, dynamic> placeData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(placeData['ImageURL']),
          SizedBox(height: 8),
          Text(
            placeData['Name'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            placeData['Description'],
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 8),
          Text('Location: ${placeData['Location']}'),
          SizedBox(height: 8),
          Text('Rating: ${placeData['Ratings']}'),
        ],
      ),
    );
  }
}
