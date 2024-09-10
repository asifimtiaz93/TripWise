import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageBookingsPage extends StatefulWidget {
  const ManageBookingsPage({super.key});

  @override
  State<ManageBookingsPage> createState() => _ManageBookingsPage();
}

class _ManageBookingsPage extends State<ManageBookingsPage> {
  final TextEditingController _bookingIdController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _tripIdController = TextEditingController();
  final TextEditingController _bookingDateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void dispose() {
    _bookingIdController.dispose();
    _userIdController.dispose();
    _tripIdController.dispose();
    _bookingDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _selectBookingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _bookingDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _bookingIdController,
                decoration: const InputDecoration(
                  labelText: 'BookingID (PK)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: 'UserID (FK)',
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
                controller: _bookingDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'BookingDate',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectBookingDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Status',
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
