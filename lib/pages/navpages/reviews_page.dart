// lib/pages/navpages/reviews_page.dart

import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ReviewsPage({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Sample reviews data
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'Ahmed Hasan',
        'rating': 4.5,
        'review': 'Amazing place! Had a great time with family.',
      },
      {
        'name': 'Razia Sultana',
        'rating': 4.0,
        'review': 'Beautiful scenery and friendly locals.',
      },
      {
        'name': 'Sajid Khan',
        'rating': 5.0,
        'review': 'Absolutely loved it! Will visit again.',
      },
      {
        'name': 'Fatema Begum',
        'rating': 3.5,
        'review': 'Nice place but could be cleaner.',
      },
      {
        'name': 'Mahmudul Islam',
        'rating': 4.5,
        'review': 'Great experience, highly recommend!',
      },
      {
        'name': 'Ayesha Akter',
        'rating': 4.0,
        'review': 'Had a wonderful time!',
      },
      {
        'name': 'Kamrul Hossain',
        'rating': 5.0,
        'review': 'A must-visit destination in Bangladesh.',
      },
      {
        'name': 'Sumaiya Rahman',
        'rating': 3.0,
        'review': 'It was okay, could be better.',
      },
      {
        'name': 'Tanvir Ahmed',
        'rating': 4.5,
        'review': 'Beautiful place, enjoyed every moment.',
      },
      {
        'name': 'Nafisa Yeasmin',
        'rating': 4.0,
        'review': 'Loved the ambiance and the views.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$title Reviews',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      review['name'] as String,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < (review['rating'] as double).round()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                );
                              }),
                            ),
                            SizedBox(width: 8),
                            Text(
                              review['rating'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(review['review'] as String),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
