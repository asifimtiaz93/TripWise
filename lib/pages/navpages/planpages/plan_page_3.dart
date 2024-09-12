import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/planpages/plan_page_final.dart';

class PlanPage3 extends StatefulWidget {
  final String location; // Pass the location from previous pages
  final DateTimeRange selectedDateRange; // Pass the selected date range
  final String selectedOption; // Pass the selected option from PlanPage2
  final String? travelWithChildren; // Pass the travel with children option (nullable)

  const PlanPage3({
    super.key,
    required this.location,
    required this.selectedDateRange,
    required this.selectedOption,
    this.travelWithChildren, // Nullable travel with children
  });

  @override
  State<PlanPage3> createState() => _PlanPage3State();
}

class _PlanPage3State extends State<PlanPage3> {
  final List<String> _options = [
    'Adventure Sports',     // Mapped to 'AdventureSports'
    'Beach Relaxation',     // Mapped to 'Beaches'
    'City Exploration',     // Mapped to 'Cities'
    'Cultural Experiences', // Mapped to 'CulturalSites'
    'Historical Landmarks', // Mapped to 'HistoricalPlaces'
    'Mountain Hikes',       // Mapped to 'Mountains'
  ];

  final List<bool> _selected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Activities'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'How do you want to spend your time?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Choose as many as you like.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(_options.length, (index) {
                return ChoiceChip(
                  label: Text(_options[index]),
                  selected: _selected[index],
                  onSelected: (bool selected) {
                    setState(() {
                      _selected[index] = selected;
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: _selected[index] ? Colors.white : Colors.black,
                  ),
                );
              }),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Collect selected activities and pass them to PlanReadyPage
                  List<String> selectedActivities = [];
                  for (int i = 0; i < _options.length; i++) {
                    if (_selected[i]) {
                      selectedActivities.add(_options[i]);
                    }
                  }

                  // Navigate to PlanReadyPage with the selected activities, location, date range, selected option, and travel with children
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanReadyPage(
                        location: widget.location,
                        selectedDateRange: widget.selectedDateRange,
                        selectedOption: widget.selectedOption, // Pass selected option
                        travelWithChildren: widget.travelWithChildren, // Pass travel with children if applicable
                        selectedActivities: selectedActivities, // Pass selected activities
                      ),
                    ),
                  );
                },
                child: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
