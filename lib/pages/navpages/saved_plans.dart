import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/plan_details.dart';

class SavedPlansPage extends StatefulWidget {
  @override
  _SavedPlansPageState createState() => _SavedPlansPageState();
}

class _SavedPlansPageState extends State<SavedPlansPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Plans'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: currentUser == null
          ? Center(
        child: Text('Please log in to view saved plans'),
      )
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Plans')
            .where('userId', isEqualTo: currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No saved plans found.'));
          }

          final plans = snapshot.data!.docs;

          return ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> planData =
              plans[index].data() as Map<String, dynamic>;

              return _buildPlanThumbnail(
                planData: planData,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlanDetailsPage(
                        planData: planData,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPlanThumbnail({
    required Map<String, dynamic> planData,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: onTap,
        title: Text(planData['name'] ?? 'No Name'),
        subtitle: Text(planData['location'] ?? 'Unknown Location'),
        trailing: Text(
          planData['selectedDateRange'] != null
              ? (planData['selectedDateRange']['start'] as Timestamp)
              .toDate()
              .toString()
              : 'No Date',
        ),
      ),
    );
  }
}
