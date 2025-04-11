import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'screens/login_screen.dart'; // Create next
import 'screens/matching_screen.dart'; // Create later

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>( // Listen directly if easier
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          // User is logged in
          return MatchingScreen(); // Go to matching screen
        }
        // User is not logged in
        return LoginScreen();
      }
    );
     /* // Alternative using Provider state
     if (authService.currentUser != null) {
       return MatchingScreen(); // Go to matching screen
     } else {
       return LoginScreen(); // Go to login screen
     }
     */
  }
}