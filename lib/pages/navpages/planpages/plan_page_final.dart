import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class PlanReadyPage extends StatelessWidget {
  const PlanReadyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
              child: Text('Your Plan in ready!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              )
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOptionButton('Option 1'),
                    const SizedBox(width: 8),
                    _buildOptionButton('Option 2'),
                    const SizedBox(width: 8),
                    _buildOptionButton('Option 3'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildDayPlan(
                day: 'Day 1',
                title: 'Shada Pathor',
                imageUrl:
                'assets/places/shadapathor.jpg',
                rating: 4.5,
                reviews: 105,
                category: 'Natural Beauty',
                duration: '2-3 hours',
                description:
                'Shadapathor, located in Bangladesh, is a picturesque natural attraction renowned for its breathtaking beauty and serene surroundings. Nestled amidst lush greenery and rolling hills, Shadapathor is celebrated for its tranquil atmosphere and scenic vistas. The area is characterized by captivating waterfalls cascading down rugged cliffs, creating an enchanting spectacle for visitors. Shadapathor offers an ideal retreat for nature lovers, adventurers, and those seeking a peaceful escape from the hustle and bustle of urban life.',
                price: 'BDT 500 per person',
              ),
              const SizedBox(height: 16),
              _buildDayPlan(
                day: '',
                title: 'Ratargul Swamp Forest',
                imageUrl:
                'assets/places/Ratargul.jpg',
                rating: 4.8,
                reviews: 85,
                category: 'Natural Beauty',
                duration: '3-4 hours',
                description:
                'Ratargul Swamp Forest is a freshwater swamp forest located in Gowainghat, Sylhet, Bangladesh. It is the only swamp forest located in Bangladesh and one of the few swamp forests located in the Indian subcontinent. The forest is naturally conserved under the Department of Forestry, Government of Bangladesh.',
                price: 'BDT 700 per person',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('Places to stay'),
              _buildPlaceToStayEat(
                imageUrl:
                'assets/places/nazimgar.jpeg',
                title: 'Nazimgarh Resort',
                rating: 4.5,
                reviews: 105,
                category: '4 star hotel',
                price: 'BDT 3k-4k per night',
              ),
              _buildPlaceToStayEat(
                imageUrl:
                'assets/places/shuktara.jpg',
                title: 'Shuktara Resort',
                rating: 4.5,
                reviews: 105,
                category: '4 star hotel',
                price: 'BDT 3k-4k per night',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('Places to eat'),
              _buildPlaceToStayEat(
                imageUrl:
                'assets/places/panshi.jpeg',
                title: 'Panshi',
                rating: 4.5,
                reviews: 105,
                category: '4 star hotel',
                price: 'BDT 3k-4k per night',
              ),
              _buildPlaceToStayEat(
                imageUrl:
                'assets/places/panch.jpeg',
                title: 'Panch Bhai Restaurant',
                rating: 4.5,
                reviews: 105,
                category: '4 star hotel',
                price: 'BDT 3k-4k per night',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('Transportation Plan'),
              _buildTransportPlan(
                imageUrl:
                'assets/places/cng.jpg',
                title: 'Rent CNG',
                price: 'BDT 1500 per day',
              ),
              _buildTransportPlan(
                imageUrl:
                'assets/places/auto.jpeg',
                title: 'Rent Auto Rickshaw',
                price: 'BDT 1000 per day',
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Success!',
                        message: 'You have successfully selected your plan!',
                        contentType: ContentType.success,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Select Plan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildDayPlan({
    required String day,
    required String title,
    required String imageUrl,
    required double rating,
    required int reviews,
    required String category,
    required String duration,
    required String description,
    required String price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (day.isNotEmpty)
          Text(
            day,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              '$rating',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 4),
            Text(
              '($reviews)',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Spacer(),
            Text(
              category,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Text(
              duration,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'from $price',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Divider(thickness: 1, color: Colors.grey),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPlaceToStayEat({
    required String imageUrl,
    required String title,
    required double rating,
    required int reviews,
    required String category,
    required String price,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$rating',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '($reviews)',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransportPlan({
    required String imageUrl,
    required String title,
    required String price,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


