import 'dart:io'; // Add this import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePageEdit extends StatefulWidget {
  final User? user;

  const ProfilePageEdit({super.key, this.user});

  @override
  _ProfilePageEditState createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (widget.user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(widget.user!.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          _nameController.text = userData['Name'] ?? '';
          _emailController.text = userData['Email'] ?? '';
          // You can set other fields here if needed
        }
      } else {
        _nameController.text = widget.user?.displayName ?? '';
        _emailController.text = widget.user?.email ?? '';
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _changeProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('userProfilePictures')
          .child('${widget.user!.uid}.jpg');
      await storageRef.putFile(File(pickedFile.path));
      final downloadURL = await storageRef.getDownloadURL();

      // Update the user profile
      await widget.user!.updatePhotoURL(downloadURL);

      // Update Firestore
      await FirebaseFirestore.instance.collection('User').doc(widget.user!.uid).update({
        'ProfilePicture': downloadURL,
      });

      setState(() {
        // Trigger UI update
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated successfully')),
      );
    }
  }

  Future<void> _updateProfile() async {
    User? user = widget.user;

    try {
      // Update display name
      if (_nameController.text.isNotEmpty && user != null) {
        await user.updateDisplayName(_nameController.text);
      }

      // Update email
      if (_emailController.text.isNotEmpty && user != null) {
        await user.updateEmail(_emailController.text);
      }

      // Update password
      if (_passwordController.text.isNotEmpty && user != null) {
        await user.updatePassword(_passwordController.text);
      }

      // Update Firestore
      if (user != null) {
        await FirebaseFirestore.instance.collection('User').doc(user.uid).update({
          'Name': _nameController.text,
          'Email': _emailController.text,
          'ProfilePicture': user.photoURL ?? '',
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Update failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: widget.user?.photoURL != null
                  ? NetworkImage(widget.user!.photoURL!)
                  : const AssetImage('assets/profile.jpeg') as ImageProvider,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _changeProfilePicture,
              child: const Text(
                'Change Picture',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email Id',
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: _passwordController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
