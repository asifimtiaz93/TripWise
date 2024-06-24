import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/planpages/plan_page_3.dart';
import 'package:tripwise/widgets/app_large_text.dart';
import 'package:tripwise/widgets/app_text.dart';

class PlanPage2 extends StatelessWidget {
  const PlanPage2({super.key});

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
            const Text(
              'Choose one.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 46,
            ),
            Container(
              height: 200, // Fixed height for GridView
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: const [
                  SelectableCard(
                    icon: Icons.person,
                    label: 'Solo',
                  ),
                  SelectableCard(
                    icon: Icons.favorite,
                    label: 'Partner',
                  ),
                  SelectableCard(
                    icon: Icons.group,
                    label: 'Friends',
                  ),
                  SelectableCard(
                    icon: Icons.family_restroom,
                    label: 'Family',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            AppText(
              text: 'Are you traveling with children?',
              size: 18,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Yes'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('No'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const PlanPage3()),
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

class SelectableCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const SelectableCard({required this.icon, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        onTap: () {
          // Handle card tap
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8), // Reduced padding to make the box smaller
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30), // Reduced icon size
              const SizedBox(height: 4), // Reduced space between icon and text
              Text(label, style: const TextStyle(fontSize: 14)), // Reduced font size
            ],
          ),
        ),
      ),
    );
  }
}

