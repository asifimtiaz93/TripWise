import 'package:flutter/material.dart';

class ManageFoodPage extends StatefulWidget {
  const ManageFoodPage({super.key});

  @override
  State<ManageFoodPage> createState() => _ManageFoodPageState();
}

class _ManageFoodPageState extends State<ManageFoodPage> {
  final TextEditingController _foodIdController = TextEditingController();
  final TextEditingController _destinationIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _foodIdController.dispose();
    _destinationIdController.dispose();
    _nameController.dispose();
    _typeController.dispose();
    _ratingController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _foodIdController,
                decoration: const InputDecoration(
                  labelText: 'FoodID (PK)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
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
                controller: _typeController,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
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
              ElevatedButton(
                onPressed: () {
                  // Handle form submission logic here
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
