// lib/pages/navpages/popular_places.dart

import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/destination_details.dart';

class PopularPlacesPage extends StatelessWidget {
  const PopularPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Popular Places",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Popular Places in Sylhet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return popularPlaceCard(context, places[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget popularPlaceCard(BuildContext context, Place place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailsPage(
              title: place.name,
              location: place.location,
              rating: place.rating,
              imageUrl: place.imageUrl,
              description: "Ratargul Swamp Forest is a freshwater swamp forest in Bangladesh and one of the few freshwater swamp forests in the world. You can never imagine how silence could be so enjoyable until you visit the amazing beauty.",
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  place.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    place.location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        place.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "৳${place.price}/Person",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Place {
  final String name;
  final String location;
  final double rating;
  final int price;
  final String imageUrl;

  Place({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
  });
}

final List<Place> places = [
  Place(
    name: "Ratargul",
    location: "Gowainghat, Sylhet",
    rating: 4.7,
    price: 4590,
    imageUrl: "assets/images/Ratargul.jpg",
  ),
  Place(
    name: "Shada Pathor",
    location: "Bholaganj, Sylhet",
    rating: 4.8,
    price: 8940,
    imageUrl: "assets/images/Shada Pathor.jpg",
  ),
  Place(
    name: "Jaflong",
    location: "Tamabil, Sylhet",
    rating: 4.3,
    price: 7610,
    imageUrl: "assets/images/jaflong.jpg",
  ),
  Place(
    name: "Lalakhal",
    location: "Jaintapur, Sylhet",
    rating: 4.5,
    price: 8570,
    imageUrl: "assets/images/lalakhal.jpg",
  ),
];
