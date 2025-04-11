import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_service.dart';
import '../firestore_service.dart'; // Import Firestore service

class RegistrationScreen extends StatelessWidget {
  final String userType; // 'youth' or 'business'
  RegistrationScreen({required this.userType});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController(); // Simple text input

  final FirestoreService _firestoreService = FirestoreService(); // Instance

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final nameLabel = userType == 'youth' ? 'Your Name' : 'Business Name';
    final skillsLabel = userType == 'youth' ? 'Your Skills (comma-separated)' : 'Skills Needed (comma-separated)';

    return Scaffold(
      appBar: AppBar(title: Text('Register as ${userType.capitalize()}')), // Helper extension below
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Allows scrolling if keyboard appears
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 10),
              TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
              SizedBox(height: 10),
              TextField(controller: _nameController, decoration: InputDecoration(labelText: nameLabel)),
              SizedBox(height: 10),
              TextField(controller: _skillsController, decoration: InputDecoration(labelText: skillsLabel, hintText: 'e.g., Writing, Social Media, Editing')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  final name = _nameController.text.trim();
                  final skills = _skillsController.text.trim(); // Get raw string

                  if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && skills.isNotEmpty) {
                    User? user = await authService.signUp(email, password);
                    if (user != null) {
                      // Save additional data to Firestore
                      await _firestoreService.saveUserData(
                        uid: user.uid,
                        email: email,
                        name: name,
                        skills: skills, // Save raw comma-separated string
                        userType: userType,
                      );
                      if (context.mounted) {
                         Navigator.of(context).popUntil((route) => route.isFirst); // Go back to AuthGate
                      }
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration Failed')),
                      );
                    }
                  } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper extension for capitalization
extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}