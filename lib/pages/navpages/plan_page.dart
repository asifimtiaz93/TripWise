import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/planpages/plan_page_1.dart';
import 'package:tripwise/widgets/app_large_text.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  String _selectedLocation = '';

  void _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
        .collection('PopularPlace')
        .where('Location', isGreaterThanOrEqualTo: query)
        .where('Location', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      _searchResults = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 28.0),
          Center(
            child: AppLargeText(
              text: 'Which Location do you want to visit?',
              size: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search Places",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (query) {
                _searchPlaces(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final place = _searchResults[index];
                return ListTile(
                  title: Text(place['Location']),
                  onTap: () {
                    setState(() {
                      _selectedLocation = place['Location'];
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: ElevatedButton(
                onPressed: _selectedLocation.isNotEmpty
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlanPage1(location: _selectedLocation),
                    ),
                  );
                }
                    : null, // Disable the button if no location is selected
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(80, 40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
