import 'package:flutter/material.dart';
import 'booking_page.dart'; // Import the BookingPage to access hotel details

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({super.key});

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  String selectedCategory = 'Transport'; // Default selection for the dropdown
  final List<String> categories = ['Transport', 'Hotel', 'Popular Places'];

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
              "Your Booking History",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Centered and highlighted dropdown
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2), // Border to highlight dropdown
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  underline: SizedBox(), // Remove default underline of DropdownButton
                ),
              ),
            ),

            const SizedBox(height: 16),

            // List of filtered booking history
            Expanded(
              child: ListView.builder(
                itemCount: filteredBookingHistory().length,
                itemBuilder: (context, index) {
                  final booking = filteredBookingHistory()[index];
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

  // Function to filter booking history based on the selected category
  List<BookingHistoryItem> filteredBookingHistory() {
    switch (selectedCategory) {
      case 'Transport':
        return bookingHistory.where((item) => item.bookingType == 'Flight' || item.bookingType == 'Bus').toList();
      case 'Hotel':
        return bookingHistory.where((item) => item.bookingType == 'Hotel').toList();
      case 'Popular Places':
        return bookingHistory.where((item) => item.bookingType == 'Popular Place').toList();
      default:
        return bookingHistory;
    }
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

// Example booking history with hotels added from the Booking Page
final List<BookingHistoryItem> bookingHistory = [
  // Flight bookings
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
    imageUrl: "assets/singapore.png",
    bookingDate: "15 June 2023",
    price: 65000,
    bookingType: "Flight",
  ),

  // Bus bookings
  BookingHistoryItem(
    title: "Dhaka - Sylhet",
    subtitle: "Green Line",
    imageUrl: "assets/green_line.jpg",
    bookingDate: "1 Jan 2024",
    price: 1500,
    bookingType: "Bus",
  ),

  // Hotel bookings from the Booking Page
  BookingHistoryItem(
    title: "Hotel Sayeman, Cox's Bazar",
    subtitle: "Luxury Hotel",
    imageUrl: "assets/sayeman.png",
    bookingDate: "12 July 2023",
    price: 10500,
    bookingType: "Hotel",
  ),
  BookingHistoryItem(
    title: "Nazimgarh Resort, Sylhet",
    subtitle: "Premium Resort",
    imageUrl: "assets/nazimgarh.png",
    bookingDate: "20 Aug 2023",
    price: 9500,
    bookingType: "Hotel",
  ),

  // Popular places bookings
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
];
