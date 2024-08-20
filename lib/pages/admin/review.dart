import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ManageReviewsPage extends StatefulWidget {
  const ManageReviewsPage({super.key});

  @override
  State<ManageReviewsPage> createState() => _ManageReviewsPageState();
}

class _ManageReviewsPageState extends State<ManageReviewsPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _popularPlaceIdController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _photo;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _pickPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _photo = photo;
    });
  }

  Future<String?> _uploadPhoto(XFile photo) async {
    try {
      final Reference storageReference =
      FirebaseStorage.instance.ref().child('review_photos/${photo.name}');
      final UploadTask uploadTask = storageReference.putFile(File(photo.path));
      await uploadTask.whenComplete(() => null);
      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error uploading photo: $e');
      return null;
    }
  }

  Future<void> _submitReview() async {
    try {
      String? photoUrl;
      if (_photo != null) {
        photoUrl = await _uploadPhoto(_photo!);
      }

      await FirebaseFirestore.instance.collection('Reviews').add({
        'UserID': _userIdController.text,
        'PopularPlaceID': _popularPlaceIdController.text,
        'Rating': int.tryParse(_ratingController.text) ?? 0,
        'Comment': _commentController.text,
        'Date': _dateController.text,
        'PhotoURL': photoUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data submitted successfully')),
      );

      // Clear the text fields after submission
      _userIdController.clear();
      _popularPlaceIdController.clear();
      _ratingController.clear();
      _commentController.clear();
      _dateController.clear();
      setState(() {
        _photo = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _userIdController,
                decoration: InputDecoration(
                  labelText: 'UserID (FK)',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _popularPlaceIdController,
                decoration: InputDecoration(
                  labelText: 'PopularPlaceID (FK)',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  _photo == null
                      ? Text('No photo selected.')
                      : Image.file(
                    File(_photo!.path),
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: _pickPhoto,
                    child: Text('Pick Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _ratingController,
                decoration: InputDecoration(
                  labelText: 'Rating',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Comment',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _submitReview,
                child: Text('Push Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}