import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String flightType = 'Domestic';  // Dropdown for flight
  String busType = 'Domestic';     // Dropdown for bus
  String trainType = 'Domestic';   // Dropdown for train
  String hotelType = 'Domestic';   // Dropdown for hotel
  String hotelDestination = 'Cox\'s Bazar';  // Dropdown for hotel destinations

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
        title: const Text(
          "Booking",
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
                  // Flight Tab
                  Column(
                    children: [
                      DropdownButton<String>(
                        value: flightType,
                        items: const [
                          DropdownMenuItem(value: 'Domestic', child: Text('Domestic')),
                          DropdownMenuItem(value: 'International', child: Text('International')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            flightType = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: bookingOptionsList(flightType == 'Domestic'
                            ? flightOptionsDomestic
                            : flightOptionsInternational),
                      ),
                    ],
                  ),
                  // Train Tab
                  Column(
                    children: [
                      DropdownButton<String>(
                        value: trainType,
                        items: const [
                          DropdownMenuItem(value: 'Domestic', child: Text('Domestic')),
                          DropdownMenuItem(value: 'International', child: Text('International')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            trainType = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: bookingOptionsList(trainOptions),
                      ),
                    ],
                  ),
                  // Bus Tab
                  Column(
                    children: [
                      DropdownButton<String>(
                        value: busType,
                        items: const [
                          DropdownMenuItem(value: 'Domestic', child: Text('Domestic')),
                          DropdownMenuItem(value: 'International', child: Text('International')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            busType = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: bookingOptionsList(busType == 'Domestic'
                            ? busOptionsDomestic
                            : busOptionsInternational),
                      ),
                    ],
                  ),
                  // Hotel Tab
                  Column(
                    children: [
                      DropdownButton<String>(
                        value: hotelType,
                        items: const [
                          DropdownMenuItem(value: 'Domestic', child: Text('Domestic')),
                          DropdownMenuItem(value: 'International', child: Text('International')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            hotelType = value!;
                          });
                        },
                      ),
                      if (hotelType == 'Domestic')
                        DropdownButton<String>(
                          value: hotelDestination,
                          items: const [
                            DropdownMenuItem(value: 'Cox\'s Bazar', child: Text('Cox\'s Bazar')),
                            DropdownMenuItem(value: 'Sylhet', child: Text('Sylhet')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              hotelDestination = value!;
                            });
                          },
                        ),
                      Expanded(
                        child: bookingOptionsList(hotelType == 'Domestic'
                            ? (hotelDestination == 'Cox\'s Bazar'
                            ? hotelOptionsCoxBazar
                            : hotelOptionsSylhet)
                            : hotelOptionsInternational),
                      ),
                    ],
                  ),
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
        return InkWell(
          onTap: () async {
            if (await canLaunch(option.url)) {
              await launch(option.url);
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Image.asset(
                option.imageUrl,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              title: Text(
                option.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BookingOption {
  final String title;
  final String imageUrl;
  final String url;

  BookingOption({
    required this.title,
    required this.imageUrl,
    required this.url,
  });
}

// Correct Flight Options
final List<BookingOption> flightOptionsDomestic = [
  BookingOption(
    title: "Biman Bangladesh",
    imageUrl: "assets/Biman-Bangladesh.png",
    url: "https://biman-airlines.com/",
  ),
  BookingOption(
    title: "Air Astra",
    imageUrl: "assets/air_astra.png",
    url: "https://airastra.com/",
  ),
  BookingOption(
    title: "US Bangla",
    imageUrl: "assets/us_bangla.jpg",
    url: "https://usbair.com/",
  ),
  BookingOption(
    title: "NovoAir",
    imageUrl: "assets/novoair.jpg",
    url: "https://flynovoair.com/",
  ),
];

final List<BookingOption> flightOptionsInternational = [
  BookingOption(
    title: "Singapore Airlines",
    imageUrl: "assets/singapore.png",
    url: "https://singaporeair.com/",
  ),
  BookingOption(
    title: "Emirates",
    imageUrl: "assets/emirates.png",
    url: "https://emirates.com/",
  ),
  BookingOption(
    title: "Qatar Airways",
    imageUrl: "assets/qatar_airways.png",
    url: "https://qatarairways.com/",
  ),
  BookingOption(
    title: "Malaysian Airlines",
    imageUrl: "assets/malaysian_airlines.png",
    url: "https://malaysiaairlines.com/",
  ),
];

// Correct Bus Options
final List<BookingOption> busOptionsDomestic = [
  BookingOption(
    title: "Green Line Paribahan",
    imageUrl: "assets/green_line.jpg",
    url: "https://greenlineparibahan.com/",
  ),
  BookingOption(
    title: "Desh Travels",
    imageUrl: "assets/desh_travels.png",
    url: "https://deshtravelsbd.com/",
  ),
  BookingOption(
    title: "Shyamoli Paribahan",
    imageUrl: "assets/shyamoli_paribahan.png",
    url: "https://shyamoli.com/",
  ),
  BookingOption(
    title: "Shohagh Paribahan",
    imageUrl: "assets/shohagh_paribahan.png",
    url: "https://shohagh.com/",
  ),
];

final List<BookingOption> busOptionsInternational = [
  BookingOption(
    title: "Green Line",
    imageUrl: "assets/green_line.jpg",
    url: "https://greenlineparibahan.com/",
  ),
  BookingOption(
    title: "Shyamoli NR Travels",
    imageUrl: "assets/shyamoli_paribahan.png",
    url: "https://shyamoli.com/",
  ),
];

final List<BookingOption> trainOptions = [
  BookingOption(
    title: "Bangladesh Railway",
    imageUrl: "assets/bangladesh_railway.png",
    url: "https://eticket.railway.gov.bd/",
  ),
];

// Hotel options for different destinations
final List<BookingOption> hotelOptionsCoxBazar = [
  BookingOption(
    title: "Hotel Sayeman",
    imageUrl: "assets/sayeman.png",
    url: "https://sayemanresort.com/",
  ),
  BookingOption(
    title: "Jol Torongo",
    imageUrl: "assets/jol_torongo.png",
    url: "https://joltorongocox.com/",
  ),
  BookingOption(
    title: "Sea Pearl",
    imageUrl: "assets/sea_pearl.png",
    url: "https://seapearlcoxsbazar.com/",
  ),
  BookingOption(
    title: "Hotel Cox Today",
    imageUrl: "assets/cox_today.png",
    url: "https://coxtoday.com/",
  ),
];

final List<BookingOption> hotelOptionsSylhet = [
  BookingOption(
    title: "Grand Sultan",
    imageUrl: "assets/grand_sultan.png",
    url: "https://grandsultanresort.com/",
  ),
  BookingOption(
    title: "The Palace",
    imageUrl: "assets/palace_sylhet.png",
    url: "https://palacebd.com/",
  ),
  BookingOption(
    title: "Nazimgarh Resort",
    imageUrl: "assets/nazimgarh.png",
    url: "https://nazimgarh.com/",
  ),
];

final List<BookingOption> hotelOptionsInternational = [
  BookingOption(
    title: "Hilton International",
    imageUrl: "assets/hilton.png",
    url: "https://hilton.com/",
  ),
  BookingOption(
    title: "Marriott",
    imageUrl: "assets/marriott.png",
    url: "https://marriott.com/",
  ),
  BookingOption(
    title: "Radisson",
    imageUrl: "assets/radission.png",
    url: "https://www.radissonhotels.com/",
  ),
];
