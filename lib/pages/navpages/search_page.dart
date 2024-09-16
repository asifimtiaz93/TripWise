import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'place_detail_page.dart'; // Import your PlaceDetailPage

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Ensure Navigator is used properly
          },
        ),
        title: Text(
          'Search',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchTerm = '';
              });
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Places',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchTerm = '';
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value.toLowerCase(); // Convert search term to lowercase
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Search Results',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _searchTerm.isEmpty
                  ? const Center(child: Text('Start typing to search places...'))
                  : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('PopularPlace')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No places found.'));
                  }

                  // Filter results for case-insensitive match
                  var filteredDocs = snapshot.data!.docs.where((doc) {
                    var data =
                    doc.data() as Map<String, dynamic>;
                    var name = data['Name']
                        .toString()
                        .toLowerCase(); // Convert to lowercase
                    return name
                        .contains(_searchTerm); // Match against lowercase search term
                  }).toList();

                  if (filteredDocs.isEmpty) {
                    return const Center(
                        child: Text('No places found.'));
                  }

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      var place = filteredDocs[index];
                      var data =
                      place.data() as Map<String, dynamic>;

                      return ListTile(
                        title: Text(data['Name']),
                        subtitle: Text(data['Location']),
                        onTap: () {
                          // Navigate to PlaceDetailPage when a place is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaceDetailPage(
                                placeId: place.id, // Pass the document ID as placeId
                              ),
                            ),
                          );
                        },
                      );
                    },
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
