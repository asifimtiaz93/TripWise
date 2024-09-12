import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripwise/pages/navpages/planpages/plan_page_3.dart';
import 'package:tripwise/widgets/app_large_text.dart';

class PlanPage2 extends StatefulWidget {
  final String location; // Accept location from PlanPage1
  final DateTimeRange selectedDateRange; // Accept date range from PlanPage1

  const PlanPage2({
    Key? key,
    required this.location,
    required this.selectedDateRange,
  }) : super(key: key);

  @override
  State<PlanPage2> createState() => _PlanPage2State();
}

class _PlanPage2State extends State<PlanPage2> {
  String? _selectedOption;
  String? _travelWithChildren;

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
      // Reset _travelWithChildren when option changes
      _travelWithChildren = null;
    });
  }

  void _selectTravelWithChildren(String option) {
    setState(() {
      _travelWithChildren = option;
    });
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
            Center(
              child: AppLargeText(
                text: 'Who will be joining you?',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // Display location and selected date range
            Text(
              'Location: ${widget.location}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected Date Range: ${DateFormat('dd/MM/yyyy').format(widget.selectedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(widget.selectedDateRange.end)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              'Choose one:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              height: 180,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.4,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SelectableCard(
                    icon: Icons.person,
                    label: 'Single',
                    selected: _selectedOption == 'Single',
                    onTap: () => _selectOption('Single'),
                  ),
                  SelectableCard(
                    icon: Icons.group,
                    label: 'Family and Friends',
                    selected: _selectedOption == 'Family and Friends',
                    onTap: () => _selectOption('Family and Friends'),
                  ),
                ],
              ),
            ),
            if (_selectedOption == 'Family and Friends')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Are you traveling with children?',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _selectTravelWithChildren('Yes'),
                          child: const Text('Yes'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: _travelWithChildren == 'Yes'
                                ? Colors.blue
                                : Colors.transparent,
                            foregroundColor: _travelWithChildren == 'Yes'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _selectTravelWithChildren('No'),
                          child: const Text('No'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: _travelWithChildren == 'No'
                                ? Colors.blue
                                : Colors.transparent,
                            foregroundColor: _travelWithChildren == 'No'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _selectedOption != null &&
                    (_selectedOption != 'Family and Friends' ||
                        _travelWithChildren != null)
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanPage3(
                        location: widget.location, // Pass location to PlanPage3
                        selectedDateRange: widget.selectedDateRange, // Pass date range to PlanPage3
                        selectedOption: _selectedOption!, // Pass the selected option
                        travelWithChildren: _travelWithChildren, // Pass the travel with children option
                      ),
                    ),
                  );
                }
                    : null,
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

class SelectableCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SelectableCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.blue : Colors.black,
              width: selected ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
            color: selected ? Colors.blue.withOpacity(0.3) : Colors.transparent,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: selected ? Colors.blue : Colors.black),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? Colors.blue : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
