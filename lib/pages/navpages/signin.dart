import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripwise/pages/navpages/signup.dart';
import 'package:tripwise/pages/navpages/home_page.dart';



class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  void _handleEmailSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to home page after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => homePage(user: _user),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Sign in failed'),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Implement back navigation
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 1),
            Center(
              child: Text(
                'Please sign in to continue our app',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Implement password visibility toggle
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Implement forgot password functionality
                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
            SizedBox(height: 2),
            Center(
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleEmailSignIn,
                  child: _isLoading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don’t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1),
            Center(
              child: Text(
                'Or connect',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  OutlinedButton.icon(
                    icon: Image.asset('assets/google.png', width: 20, height: 20), // Replace with your own image asset
                    label: Text('Sign in with Google'),
                    onPressed: _handleGoogleSignIn,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      textStyle: TextStyle(fontSize: 16),
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Container(
      width: 100, // specify the width
      height: 100, // specify the height
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_user!.photoURL!),
          fit: BoxFit.cover, // optional: specify how the image should fit
        ),
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }
}
