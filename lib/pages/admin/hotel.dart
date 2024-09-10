import 'package:flutter/material.dart';

class ManageHotelsPage extends StatefulWidget {
  const ManageHotelsPage({super.key});

  @override
  State<ManageHotelsPage> createState() => _ManageHotelPageState();
}

class _ManageHotelPageState extends State<ManageHotelsPage> {
  final TextEditingController _hotelIdController = TextEditingController();
  final TextEditingController _destinationIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  void dispose() {
    _hotelIdController.dispose();
    _destinationIdController.dispose();
    _nameController.dispose();
    _ratingController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _hotelIdController,
                decoration: const InputDecoration(
                  labelText: 'HotelID (PK)',
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
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
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
