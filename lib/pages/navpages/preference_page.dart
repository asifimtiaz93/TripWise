import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool _adventureSports = false;
  bool _beaches = false;
  bool _cities = false;
  bool _culturalSites = false;
  bool _historicalPlaces = false;
  bool _mountains = false;
  String? _relationshipStatus = 'Single';

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _adventureSports = userDoc['AdventureSports'] ?? false;
            _beaches = userDoc['Beaches'] ?? false;
            _cities = userDoc['Cities'] ?? false;
            _culturalSites = userDoc['CulturalSites'] ?? false;
            _historicalPlaces = userDoc['HistoricalPlaces'] ?? false;
            _mountains = userDoc['Mountains'] ?? false;
            _relationshipStatus = userDoc['RelationshipStatus'] ?? 'Single';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User document does not exist')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading preferences: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user logged in')),
      );
    }
  }

  Future<void> _updateUserPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('User').doc(user.uid).update({
          'AdventureSports': _adventureSports,
          'Beaches': _beaches,
          'Cities': _cities,
          'CulturalSites': _culturalSites,
          'HistoricalPlaces': _historicalPlaces,
          'Mountains': _mountains,
          'RelationshipStatus': _relationshipStatus,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preferences updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating preferences: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                value: _relationshipStatus,
                items: const [
                  DropdownMenuItem(value: 'Single', child: Text('Single')),
                  DropdownMenuItem(value: 'Married', child: Text('Married')),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _relationshipStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateUserPreferences,
                child: const Text('Save Preferences'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background color
                  foregroundColor: Colors.white, // text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
