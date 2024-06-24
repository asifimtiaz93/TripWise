import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/planpages/plan_page_2.dart';
import 'package:tripwise/widgets/app_large_text.dart';
import 'package:tripwise/widgets/app_text.dart';

class PlanPage1 extends StatelessWidget {
  const PlanPage1({super.key});

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
                text: 'When do you plan to visit?',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Choose a date/range',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 46,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: const Text(
                'Trip Length',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                AppText(
                  text: 'Total days',
                  size: 18,
                  color: Colors.black,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove),
                  color: Colors.black,
                  iconSize: 20,
                  constraints: BoxConstraints.tightFor(width: 32, height: 32),
                  padding: EdgeInsets.zero,
                  splashRadius: 24,
                  splashColor: Colors.black26,
                  hoverColor: Colors.black26,
                  highlightColor: Colors.black26,
                  tooltip: 'Decrease',
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                const Text(
                  '3',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  color: Colors.black,
                  iconSize: 20,
                  constraints: BoxConstraints.tightFor(width: 32, height: 32),
                  padding: EdgeInsets.zero,
                  splashRadius: 24,
                  splashColor: Colors.black26,
                  hoverColor: Colors.black26,
                  highlightColor: Colors.black26,
                  tooltip: 'Increase',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            AppText(
              text: 'During which month?',
              size: 18,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                MonthCard(month: 'May'),
                MonthCard(month: 'June'),
                MonthCard(month: 'July'),
                MonthCard(month: 'August'),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const PlanPage2()),
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

class MonthCard extends StatelessWidget {
  final String month;
  const MonthCard({required this.month, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.calendar_today,
          size: 48,
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}


