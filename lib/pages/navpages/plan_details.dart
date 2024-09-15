import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlanDetailsPage extends StatelessWidget {
  final Map<String, dynamic> planData;

  const PlanDetailsPage({Key? key, required this.planData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${planData['name'] ?? 'No Name'}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Location: ${planData['location'] ?? 'Unknown Location'}'),
            SizedBox(height: 10),
            Text('Date: ${(planData['selectedDateRange']['start'] as Timestamp).toDate()} - ${(planData['selectedDateRange']['end'] as Timestamp).toDate()}'),
            SizedBox(height: 10),
            Text('Option: ${planData['selectedOption'] ?? 'None'}'),
            SizedBox(height: 10),
            if (planData['selectedActivities'] != null)
              Text('Activities: ${planData['selectedActivities'].join(', ')}'),
            SizedBox(height: 10),
            if (planData['travelWithChildren'] != null)
              Text('Traveling with children: ${planData['travelWithChildren']}'),
          ],
        ),
      ),
    );
  }
}
