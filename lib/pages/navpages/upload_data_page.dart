import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadDataPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadPlaces() async {
    List<Map<String, dynamic>> places = [
      {
        "Attributes": {
          "AdventureSports": false,
          "Beaches": false,
          "Cities": false,
          "CulturalSites": true,
          "HistoricalPlaces": true,
          "Mountains": false,
        },
        "Budget": "500",
        "Cost": "500",
        "Description": "Sundarbans is the largest mangrove forest in the world, located in the southwest of Bangladesh.",
        "DestinationID": "3",
        "ImageURL": "https://example.com/sundarbans.jpg",
        "Location": "Sundarbans",
        "Name": "Sundarbans",
        "Ratings": "4.9",
        "RelationStatus": "Single",
        "placeId": 8,
      },
      {
        "Attributes": {
          "AdventureSports": true,
          "Beaches": false,
          "Cities": false,
          "CulturalSites": false,
          "HistoricalPlaces": false,
          "Mountains": true,
        },
        "Budget": "1200",
        "Cost": "1200",
        "Description": "Bandarban is a hill district in southeastern Bangladesh, known for its lush mountains and trekking trails.",
        "DestinationID": "4",
        "ImageURL": "https://example.com/bandarban.jpg",
        "Location": "Bandarban",
        "Name": "Bandarban",
        "Ratings": "4.7",
        "RelationStatus": "Single",
        "placeId": 9,
      },
      {
        "Attributes": {
          "AdventureSports": false,
          "Beaches": true,
          "Cities": false,
          "CulturalSites": false,
          "HistoricalPlaces": true,
          "Mountains": false,
        },
        "Budget": "400",
        "Cost": "400",
        "Description": "Kuakata is a panoramic sea beach located in the southernmost part of Bangladesh, known for its sunrise and sunset views.",
        "DestinationID": "5",
        "ImageURL": "https://example.com/kuakata.jpg",
        "Location": "Kuakata",
        "Name": "Kuakata",
        "Ratings": "4.5",
        "RelationStatus": "Single",
        "placeId": 10,
      },
      {
        "Attributes": {
          "AdventureSports": false,
          "Beaches": false,
          "Cities": true,
          "CulturalSites": false,
          "HistoricalPlaces": true,
          "Mountains": false,
        },
        "Budget": "600",
        "Cost": "600",
        "Description": "Dhaka is the capital city of Bangladesh, known for its bustling markets, Mughal architecture, and cultural significance.",
        "DestinationID": "6",
        "ImageURL": "https://example.com/dhaka.jpg",
        "Location": "Dhaka",
        "Name": "Dhaka",
        "Ratings": "4.6",
        "RelationStatus": "Single",
        "placeId": 11,
      },
      {
        "Attributes": {
          "AdventureSports": true,
          "Beaches": false,
          "Cities": false,
          "CulturalSites": true,
          "HistoricalPlaces": true,
          "Mountains": true,
        },
        "Budget": "900",
        "Cost": "900",
        "Description": "Sajek Valley, located in Rangamati district, is a popular hill station in the Chittagong Hill Tracts, known for scenic beauty.",
        "DestinationID": "7",
        "ImageURL": "https://example.com/sajek.jpg",
        "Location": "Sajek Valley",
        "Name": "Sajek Valley",
        "Ratings": "4.8",
        "RelationStatus": "Single",
        "placeId": 12,
      },
      {
        "Attributes": {
          "AdventureSports": false,
          "Beaches": false,
          "Cities": false,
          "CulturalSites": true,
          "HistoricalPlaces": true,
          "Mountains": false,
        },
        "Budget": "700",
        "Cost": "700",
        "Description": "Paharpur is the site of an ancient Buddhist monastery, and it's a UNESCO World Heritage Site in Bangladesh.",
        "DestinationID": "8",
        "ImageURL": "https://example.com/paharpur.jpg",
        "Location": "Paharpur",
        "Name": "Paharpur",
        "Ratings": "4.7",
        "RelationStatus": "Single",
        "placeId": 13,
      },
      {
        "Attributes": {
          "AdventureSports": true,
          "Beaches": false,
          "Cities": false,
          "CulturalSites": true,
          "HistoricalPlaces": false,
          "Mountains": true,
        },
        "Budget": "1100",
        "Cost": "1100",
        "Description": "Jaflong is a scenic tourist spot in Sylhet, surrounded by tea gardens and hills with a river flowing through.",
        "DestinationID": "9",
        "ImageURL": "https://example.com/jaflong.jpg",
        "Location": "Jaflong",
        "Name": "Jaflong",
        "Ratings": "4.6",
        "RelationStatus": "Single",
        "placeId": 14,
      },
      {
        "Attributes": {
          "AdventureSports": false,
          "Beaches": false,
          "Cities": false,
          "CulturalSites": true,
          "HistoricalPlaces": true,
          "Mountains": false,
        },
        "Budget": "600",
        "Cost": "600",
        "Description": "Sonargaon was a historic administrative and commercial city in Bengal, and now a popular historical site near Dhaka.",
        "DestinationID": "10",
        "ImageURL": "https://example.com/sonargaon.jpg",
        "Location": "Sonargaon",
        "Name": "Sonargaon",
        "Ratings": "4.7",
        "RelationStatus": "Single",
        "placeId": 15,
      },
      {
        "Attributes": {
          "AdventureSports": false,
          "Beaches": false,
          "Cities": true,
          "CulturalSites": false,
          "HistoricalPlaces": true,
          "Mountains": false,
        },
        "Budget": "800",
        "Cost": "800",
        "Description": "Chittagong is a major coastal city in southeastern Bangladesh, known for its port and nearby tourist spots.",
        "DestinationID": "11",
        "ImageURL": "https://example.com/chittagong.jpg",
        "Location": "Chittagong",
        "Name": "Chittagong",
        "Ratings": "4.6",
        "RelationStatus": "Single",
        "placeId": 16,
      },
      {
        "Attributes": {
          "AdventureSports": true,
          "Beaches": false,
          "Cities": false,
          "CulturalSites": false,
          "HistoricalPlaces": true,
          "Mountains": true,
        },
        "Budget": "1200",
        "Cost": "1200",
        "Description": "Lalbagh Fort is an incomplete Mughal palace fortress in Dhaka, Bangladesh, dating back to the 17th century.",
        "DestinationID": "12",
        "ImageURL": "https://example.com/lalbagh.jpg",
        "Location": "Lalbagh Fort",
        "Name": "Lalbagh Fort",
        "Ratings": "4.7",
        "RelationStatus": "Single",
        "placeId": 17,
      },
    ];

    for (var place in places) {
      try {
        await _firestore.collection('PopularPlace').add(place);
        print('Place ${place["Name"]} uploaded successfully');
      } catch (e) {
        print('Failed to upload place ${place["Name"]}: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Places'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadPlaces,
          child: const Text('Upload Places'),
        ),
      ),
    );
  }
}
