import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlanReadyPage extends StatefulWidget {
  final String location; // Passed from PlanPage3
  final DateTimeRange selectedDateRange; // Passed from PlanPage3
  final String selectedOption; // Passed from PlanPage3 (single or family/friends)
  final String? travelWithChildren; // Passed from PlanPage3
  final List<String> selectedActivities; // Passed from PlanPage3

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
  List<Map<String, dynamic>> options = []; // Store matched options

  @override
  void initState() {
    super.initState();
    _findMatchingPlaces();
  }

  // Fetch and find the matching places
  Future<void> _findMatchingPlaces() async {
    print('Selected Activities: ${widget.selectedActivities}');
    print('Location: ${widget.location}');
    print('Selected Date Range: ${widget.selectedDateRange.start} to ${widget.selectedDateRange.end}');
    print('Selected Option: ${widget.selectedOption}');
    print('Travel With Children: ${widget.travelWithChildren}');

    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('PopularPlace').get();

    List<QueryDocumentSnapshot> places = snapshot.docs;

    print('Fetched ${places.length} places from Firestore');

    List<Map<String, dynamic>> matchedPlaces = [];

    for (var place in places) {
      Map<String, dynamic> placeData = place.data() as Map<String, dynamic>;

      // Check if the 'Attributes' field exists and is not null
      if (placeData['Attributes'] != null) {
        List<String> matchedAttributes = [];

        // Map attributes to activities
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
          print('Matched attributes: $matchedAttributes for place: ${placeData['Name']}');
          matchedPlaces.add({
            'place': placeData,
            'matchCount': matchedAttributes.length,
            'matchedActivities': matchedAttributes,
          });
        } else {
          print('No matched attributes for place: ${placeData['Name']}');
        }
      } else {
        print('No Attributes field for place: ${placeData['Name']}');
      }
    }

    // Sort matched places by match count
    matchedPlaces.sort((a, b) => b['matchCount'].compareTo(a['matchCount']));

    // Get up to 3 options
    setState(() {
      options = matchedPlaces.take(3).toList();
    });

    print('Matched ${options.length} places');
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
              // Show options or no match message
              if (options.isNotEmpty)
                Column(
                  children: List.generate(
                    options.length,
                        (index) => _buildOptionButton(
                      'Option ${index + 1}',
                      options[index]['place'],
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
              _buildSectionTitle('Selected Activities:'),
              Text(widget.selectedActivities.join(', ')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, Map<String, dynamic> placeData) {
    return OutlinedButton(
      onPressed: () {
        _showPlaceDetails(placeData);
      },
      child: Text(text),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // Show detailed place information when an option is selected
  void _showPlaceDetails(Map<String, dynamic> placeData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(placeData['Name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(placeData['ImageURL']),
              const SizedBox(height: 8),
              Text(placeData['Description']),
              const SizedBox(height: 8),
              Text('Location: ${placeData['Location']}'),
              const SizedBox(height: 8),
              Text('Rating: ${placeData['Ratings']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
