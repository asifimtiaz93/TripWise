// lib/pages/navpages/reviews_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewsPage extends StatefulWidget {
  final String title;
  final String imageUrl;

  const ReviewsPage({super.key, required this.title, required this.imageUrl});

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Wazidul Islam',
      'rating': 3.0,
      'review': 'Amazing place! Had a great time with family.',
    },
    {
      'name': 'Asif Imtiaz',
      'rating': 4.0,
      'review': 'Beautiful scenery and friendly locals.',
      'photo': 'assets/images/ratar1.jpg', // Example photo path
    },
    {
      'name': 'Fahmidur Rahman',
      'rating': 5.0,
      'review': 'Absolutely loved it! Will visit again.',
    },
    {
      'name': 'Noor Mohammad Nofaer',
      'rating': 5.0,
      'review': 'Nice peaceful place!.',
      'photo': 'assets/images/ratar2.jpg', // Example photo path
    },
  ];

  final _picker = ImagePicker();
  String? _newReviewText;
  XFile? _newReviewPhoto;
  double _newReviewRating = 0.0;

  // GlobalKey for AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addReview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Enter your review'),
                      onChanged: (value) {
                        _newReviewText = value;
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _newReviewRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              _newReviewRating = index + 1.0;
                            });
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          _newReviewPhoto = photo;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      child: Text(
                        'Add Photo from Gallery',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                        setState(() {
                          _newReviewPhoto = photo;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      child: Text(
                        'Capture Now!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_newReviewText != null && _newReviewText!.isNotEmpty) {
                          setState(() {
                            _reviews.add({
                              'name': 'Anonymous',
                              'rating': _newReviewRating,
                              'review': _newReviewText!,
                              'photo': _newReviewPhoto?.path,
                            });
                            _newReviewText = null;
                            _newReviewPhoto = null;
                            _newReviewRating = 0.0;
                          });
                          Navigator.pop(context);
                          _listKey.currentState?.insertItem(0);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.title} Reviews',
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
            widget.imageUrl,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _reviews.length,
              itemBuilder: (context, index, animation) {
                final review = _reviews[index];
                return SizeTransition(
                  sizeFactor: animation,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        review['name'] ?? 'Anonymous',
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
                                (review['rating']?.toString() ?? 'N/A'),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(review['review'] ?? ''),
                          if (review.containsKey('photo') && review['photo'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                review['photo'],
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _addReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text(
                'Add Review',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
