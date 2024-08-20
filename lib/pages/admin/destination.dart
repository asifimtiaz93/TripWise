import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ManageDestinationsPage extends StatefulWidget {
  const ManageDestinationsPage({super.key});

  @override
  State<ManageDestinationsPage> createState() => _ManageDestinationsPageState();
}

class _ManageDestinationsPageState extends State<ManageDestinationsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  File? _imageFile;
  bool _isUploading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageAndSaveDestination() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload the image to Firebase Storage
      String fileName = _imageFile!.path.split('/').last;
      Reference storageRef = FirebaseStorage.instance.ref().child('destinations/$fileName');
      UploadTask uploadTask = storageRef.putFile(_imageFile!);

      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Save destination data to Firestore
      DocumentReference docRef = await FirebaseFirestore.instance.collection('Destination').add({
        'Name': _nameController.text,
        'Description': _descriptionController.text,
        'Location': _locationController.text,
        'Rating': double.tryParse(_ratingController.text) ?? 0.0,
        'ImageURL': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Destination added successfully with ID: ${docRef.id}')),
      );

      _nameController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _ratingController.clear();
      setState(() {
        _imageFile = null;
        _isUploading = false;
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add destination: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Destinations'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _ratingController,
                decoration: InputDecoration(
                  labelText: 'Rating',
                  hintText: 'Enter a number between 0 and 5',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              _imageFile == null
                  ? ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              )
                  : Image.file(_imageFile!),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadImageAndSaveDestination,
                child: _isUploading ? CircularProgressIndicator() : Text('Save Destination'),
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
