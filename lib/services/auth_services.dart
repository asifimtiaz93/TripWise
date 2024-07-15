import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Fetch additional user details, such as display name
      User? user = userCredential.user;
      if (user != null) {
        await user.reload(); // Reload user data to get updated profile information
        user = _auth.currentUser; // Refresh the user object

        // Try to get displayName from the GoogleSignInAccount
        String displayName = googleUser.displayName ?? user?.displayName ?? "No display name";
        print('User signed in with Google: $displayName (${user?.email})');
      }

      return user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in with Google failed: $e'),
        ),
      );
      return null;
    }
  }
}
