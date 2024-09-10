
// lib/pages/navpages/booking_history.dart

import 'package:flutter/material.dart';
import 'popular_places.dart';
import 'booking_page.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking History",
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
              "Your Bookings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: bookingHistory.length,
                itemBuilder: (context, index) {
                  final booking = bookingHistory[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.asset(
                            booking.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 150,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                booking.subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Booking Type: ${booking.bookingType}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Booked on: ${booking.bookingDate}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Price: BDT ${booking.price}",
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingHistoryItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String bookingDate;
  final int price;
  final String bookingType;

  BookingHistoryItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.bookingDate,
    required this.price,
    required this.bookingType,
  });
}

// Correctly using BookingHistoryItem
final List<BookingHistoryItem> bookingHistory = [
  // Flight bookings from booking_page.dart
  BookingHistoryItem(
    title: "Dhaka - Cox's Bazar",
    subtitle: "Biman Bangladesh",
    imageUrl: "assets/Biman-Bangladesh.png",
    bookingDate: "10 Aug 2023",
    price: 5000,
    bookingType: "Flight",
  ),
  BookingHistoryItem(
    title: "Dhaka - Geneva",
    subtitle: "Singapore Airlines",
    imageUrl: "assets/Singapore_Airlines.png",
    bookingDate: "15 June 2023",
    price: 65000,
    bookingType: "Flight",
  ),
  BookingHistoryItem(
    title: "Dhaka - Sylhet",
    subtitle: "Air Astra",
    imageUrl: "assets/air_astra.png",
    bookingDate: "22 Sep 2023",
    price: 3200,
    bookingType: "Flight",
  ),

  // Bus bookings from booking_page.dart
  BookingHistoryItem(
    title: "Dhaka - Sylhet",
    subtitle: "Green Line",
    imageUrl: "assets/green_line.jpg",
    bookingDate: "1 Jan 2024",
    price: 1500,
    bookingType: "Bus",
  ),
  BookingHistoryItem(
    title: "Dhaka - Bandarban",
    subtitle: "Robi Express",
    imageUrl: "assets/robi_ex.jpg",
    bookingDate: "12 Dec 2023",
    price: 1200,
    bookingType: "Bus",
  ),

  // Popular Places bookings from popular_places.dart
  BookingHistoryItem(
    title: "Ratargul",
    subtitle: "Gowainghat, Sylhet",
    imageUrl: "assets/images/Ratargul.jpg",
    bookingDate: "5 Mar 2024",
    price: 4590,
    bookingType: "Popular Place",
  ),
  BookingHistoryItem(
    title: "Shada Pathor",
    subtitle: "Bholaganj, Sylhet",
    imageUrl: "assets/images/Shada Pathor.jpg",
    bookingDate: "12 Feb 2024",
    price: 8940,
    bookingType: "Popular Place",
  ),
  BookingHistoryItem(
    title: "Jaflong",
    subtitle: "Tamabil, Sylhet",
    imageUrl: "assets/images/jaflong.jpg",
    bookingDate: "20 Jan 2024",
    price: 7610,
    bookingType: "Popular Place",
  ),
];
>>>>>>> Stashed changes
