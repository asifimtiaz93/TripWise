import 'package:flutter/material.dart';

class planPage extends StatelessWidget {
  const planPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Which place you want to visit?"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Places",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildPlaceCard(
                  context,
                  'Sugondha Beach',
                  'Cox\'s Bazaar',
                  'https://example.com/sugondha_beach.jpg', // Replace with actual image URL
                ),
                _buildPlaceCard(
                  context,
                  'Shada Pathor',
                  'Bholagoni, Sylhet',
                  'https://example.com/shada_pathor.jpg', // Replace with actual image URL
                ),
                _buildPlaceCard(
                  context,
                  'Kaptai Lake',
                  'Kaptai, Rangamati',
                  'https://example.com/kaptai_lake.jpg', // Replace with actual image URL
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildPlaceCard(BuildContext context, String title, String subtitle, String imageUrl) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 100,
          fit: BoxFit.cover,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          // Handle card tap
        },
      ),
    );
  }
}


