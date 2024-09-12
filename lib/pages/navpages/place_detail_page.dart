import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For fetching data from Firestore

class PlaceDetailPage extends StatelessWidget {
  final String placeId; // The document ID of the place from Firestore

  const PlaceDetailPage({Key? key, required this.placeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('PopularPlace').doc(placeId).get(),
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

          // Extracting data from Firestore
          var placeData = snapshot.data!;
          String imageUrl = placeData['ImageURL'] ?? ''; // Handle potential null value
          String name = placeData['Name'] ?? 'No name available';
          String location = placeData['Location'] ?? 'No location available';
          String description = placeData['Description'] ?? 'No description available';

          // Safely handle the Ratings field
          double rating;
          try {
            rating = double.tryParse(placeData['Ratings'].toString()) ?? 0.0;
          } catch (e) {
            rating = 0.0;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image Section
                _buildMainImage(imageUrl),

                // Place Information Section
                _buildPlaceInfo(name, location, rating, description),

                // Explore Area Section (Map Placeholder)
                _buildExploreArea(),

                // User Reviews and Insights Section (Placeholder)
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

  // Widget to build the explore area section (Map Placeholder)
  Widget _buildExploreArea() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Explore the Area", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          // Placeholder for Map Widget
          Container(
            height: 150,
            color: Colors.grey[200],
            child: Center(child: Text("Map goes here")),
          ),
        ],
      ),
    );
  }

  // Widget to build the reviews and insights section (Placeholder)
  Widget _buildReviewsAndInsights() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Traveler Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Rating: 4.5"),
          SizedBox(height: 8),
          Text("Photos, reviews, Q&A will be here"),
        ],
      ),
    );
  }
}
