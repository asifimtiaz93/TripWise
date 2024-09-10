import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagePopularPlacesPage extends StatefulWidget {
  const ManagePopularPlacesPage({super.key});

  @override
  State<ManagePopularPlacesPage> createState() => _ManagePopularPlacesPageState();
}

class _ManagePopularPlacesPageState extends State<ManagePopularPlacesPage> {
  final TextEditingController _destinationIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _ratingsController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  bool _adventureSports = false;
  bool _beaches = false;
  bool _cities = false;
  bool _culturalSites = false;
  bool _historicalPlaces = false;
  bool _mountains = false;
  String _relationStatus = 'Single';

  @override
  void dispose() {
    _destinationIdController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _budgetController.dispose();
    _ratingsController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Place'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _destinationIdController,
                decoration: const InputDecoration(
                  labelText: 'DestinationID (FK)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _budgetController,
                decoration: const InputDecoration(
                  labelText: 'Budget',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ratingsController,
                decoration: const InputDecoration(
                  labelText: 'Ratings',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Cost',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Adventure Sports'),
                value: _adventureSports,
                onChanged: (bool? value) {
                  setState(() {
                    _adventureSports = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Beaches'),
                value: _beaches,
                onChanged: (bool? value) {
                  setState(() {
                    _beaches = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Cities'),
                value: _cities,
                onChanged: (bool? value) {
                  setState(() {
                    _cities = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Cultural Sites'),
                value: _culturalSites,
                onChanged: (bool? value) {
                  setState(() {
                    _culturalSites = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Historical Places'),
                value: _historicalPlaces,
                onChanged: (bool? value) {
                  setState(() {
                    _historicalPlaces = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Mountains'),
                value: _mountains,
                onChanged: (bool? value) {
                  setState(() {
                    _mountains = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Relationship Status',
                  border: OutlineInputBorder(),
                ),
                value: _relationStatus,
                items: ['Single', 'Married']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _relationStatus = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Handle form submission logic here
                  try {
                    await FirebaseFirestore.instance.collection('PopularPlace').add({
                      'DestinationID': _destinationIdController.text,
                      'Name': _nameController.text,
                      'Description': _descriptionController.text,
                      'Location': _locationController.text,
                      'Budget': _budgetController.text,
                      'Ratings': _ratingsController.text,
                      'Cost': _costController.text,
                      'Attributes': {
                        'AdventureSports': _adventureSports,
                        'Beaches': _beaches,
                        'Cities': _cities,
                        'CulturalSites': _culturalSites,
                        'HistoricalPlaces': _historicalPlaces,
                        'Mountains': _mountains,
                      },
                      'RelationStatus': _relationStatus,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data submitted successfully')),
                    );

                    // Clear the text fields and checkboxes after submission
                    _destinationIdController.clear();
                    _nameController.clear();
                    _descriptionController.clear();
                    _locationController.clear();
                    _budgetController.clear();
                    _ratingsController.clear();
                    _costController.clear();
                    setState(() {
                      _adventureSports = false;
                      _beaches = false;
                      _cities = false;
                      _culturalSites = false;
                      _historicalPlaces = false;
                      _mountains = false;
                      _relationStatus = 'Single';
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to submit data: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background color
                  foregroundColor: Colors.white, // text color
                ),
                child: const Text('Submit Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
