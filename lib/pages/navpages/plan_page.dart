import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/planpages/plan_page_1.dart';
import 'package:tripwise/widgets/app_large_text.dart';
import 'package:tripwise/widgets/responsive_button.dart';

class planPage extends StatelessWidget {
  List<String> images = [
    "assets/places/sugondha.jpg",
    "assets/places/shadapathor.jpg",
    "assets/places/kaptai_lake.jpg",
  ];

   planPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 28.0),
          Center(
            child: AppLargeText(
              text: 'Which Place you want to visit?',
              size: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search Places",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return _buildPlaceCard(
                  context,
                  ['Sugondha Beach', 'Shada Pathor', 'Kaptai Lake'][index],
                  ['Cox\'s Bazaar', 'Bholagoni, Sylhet', 'Kaptai, Rangamati'][index],
                  images[index],
                );
              },
            ),
          ),
          const SizedBox(height: 14,),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>PlanPage1()),
                  );
                },
                child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(80,40),
                ),
              ),
            ),
          )


        ],
      ),
    );
  }

  Widget _buildPlaceCard(BuildContext context, String title, String subtitle, String imageUrl) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Image.asset(
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

