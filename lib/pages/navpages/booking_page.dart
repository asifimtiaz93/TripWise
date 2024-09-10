// lib/pages/navpages/booking_page.dart

import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking",
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
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: const [
                Tab(icon: Icon(Icons.flight), text: "Flight"),
                Tab(icon: Icon(Icons.train), text: "Train"),
                Tab(icon: Icon(Icons.directions_bus), text: "Bus"),
                Tab(icon: Icon(Icons.hotel), text: "Hotel"),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  bookingOptionsList(flightOptions),
                  const Center(child: Text("Train booking not available yet.")),
                  bookingOptionsList(busOptions),
                  const Center(child: Text("Hotel booking not available yet.")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingOptionsList(List<BookingOption> options) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
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
                  option.imageUrl,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      option.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Start from BDT ${option.price}",
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
    );
  }
}

class BookingOption {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int price;

  BookingOption({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
  });
}

final List<BookingOption> flightOptions = [
  BookingOption(
    title: "Dhaka - Cox's Bazar",
    subtitle: "Biman Bangladesh",
    imageUrl: "assets/Biman-Bangladesh.png",
    price: 5000,
  ),
  BookingOption(
    title: "Dhaka - Geneva",
    subtitle: "Singapore Airlines",
    imageUrl: "assets/Singapore_Airlines.png",
    price: 65000,
  ),
  BookingOption(
    title: "Dhaka - Sylhet",
    subtitle: "Air Astra",
    imageUrl: "assets/air_astra.png",
    price: 3200,
  ),
];

final List<BookingOption> busOptions = [
  BookingOption(
    title: "Dhaka - Sylhet",
    subtitle: "Green Line",
    imageUrl: "assets/green_line.jpg",
    price: 1500,
  ),
  BookingOption(
    title: "Dhaka - Bandarban",
    subtitle: "Robi Express",
    imageUrl: "assets/robi_ex.jpg",
    price: 1200,
  ),
  BookingOption(
    title: "Khulna - Dhaka",
    subtitle: "Desh Travels",
    imageUrl: "assets/Desh-Travels.png",
    price: 1300,
  ),
];
