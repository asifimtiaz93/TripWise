import 'package:flutter/material.dart';

class PlanPage3 extends StatefulWidget {
  const PlanPage3({super.key});

  @override
  State<PlanPage3> createState() => _PlanPage3State();
}

class _PlanPage3State extends State<PlanPage3> {
  final List<String> _options = [
    'Must-see attractions',
    'Great Food',
    'Hidden Gems',
    'Beach Resorts',
    'Historical Sites',
    'River Cruises',
    'Shopping',
    'Cultural Experiences',
    'Natural Reserves',
    'Temples and Mosques',
    'Folk Arts and Crafts',
    'Adventure Activities'
  ];

  final List<bool> _selected = List.generate(12, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button action
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
                  // Navigate to next page
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vrpano),
            label: 'VR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }
}


