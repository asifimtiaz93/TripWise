import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripwise/pages/navpages/planpages/plan_page_2.dart';
import 'package:tripwise/widgets/app_large_text.dart';
import 'package:tripwise/widgets/app_text.dart';

class PlanPage1 extends StatefulWidget {
  final String location; // Accept the location passed from PlanPage

  const PlanPage1({super.key, required this.location});

  @override
  State<PlanPage1> createState() => _PlanPage1State();
}

class _PlanPage1State extends State<PlanPage1> {
  DateTimeRange? _selectedDateRange;
  int get _totalDays => _selectedDateRange != null
      ? _selectedDateRange!.end.difference(_selectedDateRange!.start).inDays + 1
      : 0;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: AppLargeText(
                text: 'Planning a trip to ${widget.location}!', // Display the location here
                size: 18,
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: AppLargeText(
                text: 'When do you plan to visit?',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Choose a date range',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 46.0),
            GestureDetector(
              onTap: () => _selectDateRange(context),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDateRange == null
                          ? 'Select Date Range'
                          : '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_selectedDateRange != null)
              AppText(
                text: 'Total days: $_totalDays',
                size: 18,
                color: Colors.black,
              ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _selectedDateRange == null
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanPage2(
                        location: widget.location,
                        selectedDateRange: _selectedDateRange!, // Use null assertion operator
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
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
