import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For fetching data from Firestore

class PlaceDetailPage extends StatefulWidget {
  final String placeId; // The document ID of the place from Firestore

  const PlaceDetailPage({Key? key, required this.placeId}) : super(key: key);

  @override
  _PlaceDetailPageState createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('PopularPlace').doc(widget.placeId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data available'));
          }

          var placeData = snapshot.data!;
          String imageUrl = placeData['ImageURL'] ?? ''; // Handle potential null value
          String name = placeData['Name'] ?? 'No name available';
          String location = placeData['Location'] ?? 'No location available';
          String description = placeData['Description'] ?? 'No description available';
          double rating = double.tryParse(placeData['Ratings'].toString()) ?? 0.0;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image Section
                _buildMainImage(imageUrl),

                // Place Information Section
                _buildPlaceInfo(name, location, rating, description),

                // Traveler Insights and Reviews Section
                _buildReviewsAndInsights(),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget to build the main image section
  Widget _buildMainImage(String imageUrl) {
    return imageUrl.isNotEmpty
        ? Image.network(
      imageUrl,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    )
        : Container(
      height: 250,
      color: Colors.grey[200],
      child: Center(child: Text("No image available")),
    );
  }

  // Widget to build the place info section
  Widget _buildPlaceInfo(String name, String location, double rating, String description) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_pin),
              SizedBox(width: 4),
              Text(location, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 4),
              Text(rating.toString(), style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 16),
          Text(description, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Widget to build the reviews and insights section
  Widget _buildReviewsAndInsights() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Traveler Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),

          // Fetch and display user reviews
          _buildUserReviews(),

          SizedBox(height: 16),

          // Review writing section at the bottom
          _buildUserReviewSection(),
        ],
      ),
    );
  }

  // Method to fetch and display user reviews
  Widget _buildUserReviews() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Review')
          .where('placeId', isEqualTo: widget.placeId)
          .orderBy('date', descending: true)
          .snapshots(), // Use StreamBuilder to get live updates
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text("No reviews yet.", style: TextStyle(color: Colors.grey));
        }

        var reviews = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: reviews.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            var review = data['review'] ?? '';
            var date = (data['date'] as Timestamp).toDate();
            var userId = data['userId'] ?? '';

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('User').doc(userId).get(),
              builder: (context, userSnapshot) {
                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return SizedBox.shrink(); // No user data, don't display review
                }

                var userData = userSnapshot.data!;
                var userName = userData['Name'] ?? 'Anonymous';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(review, style: TextStyle(fontSize: 16)),
                            SizedBox(height: 4),
                            Text(
                              'Posted on ${date.toString().split(' ')[0]}',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  // Widget to build the user review section
  Widget _buildUserReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Write a Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: _reviewController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Write your review here...',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _postReview,
          child: Text(currentUser != null ? 'Post Review' : 'Log in required'),
          style: ElevatedButton.styleFrom(
            backgroundColor: currentUser != null ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  // Method to post the review to Firestore
  Future<void> _postReview() async {
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please log in to post a review.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Review cannot be empty.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Save review to Firestore
    await FirebaseFirestore.instance.collection('Review').add({
      'placeId': widget.placeId,
      'review': _reviewController.text.trim(),
      'userId': currentUser!.uid,
      'date': DateTime.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Review posted successfully!'),
      backgroundColor: Colors.green,
    ));

    _reviewController.clear(); // Clear the input field
  }
}
