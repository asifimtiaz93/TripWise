import 'package:flutter/material.dart';

class ManageTransportationPage extends StatefulWidget {
  const ManageTransportationPage({super.key});

  @override
  State<ManageTransportationPage> createState() => _ManageTransportationPageState();
}

class _ManageTransportationPageState extends State<ManageTransportationPage> {
  final TextEditingController _transportIdController = TextEditingController();
  final TextEditingController _popularPlaceIdController = TextEditingController();
  final TextEditingController _tripIdController = TextEditingController();
  final TextEditingController _modeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _transportIdController.dispose();
    _popularPlaceIdController.dispose();
    _tripIdController.dispose();
    _modeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transportation'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _transportIdController,
                decoration: const InputDecoration(
                  labelText: 'TransportID (PK)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _popularPlaceIdController,
                decoration: const InputDecoration(
                  labelText: 'PopularPlaceID (FK)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tripIdController,
                decoration: const InputDecoration(
                  labelText: 'TripID (FK)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _modeController,
                decoration: const InputDecoration(
                  labelText: 'Mode',
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
