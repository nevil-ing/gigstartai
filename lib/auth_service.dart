import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners(); 
    });
  }

  User? get currentUser => _user;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _user = result.user;
      notifyListeners();
      return _user;
    } on FirebaseAuthException catch (e) {
      print("SIGNUP ERROR: ${e.message}"); // Basic error handling
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       _user = result.user;
       notifyListeners();
      return _user;
    } on FirebaseAuthException catch (e) {
      print("SIGNIN ERROR: ${e.message}"); // Basic error handling
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    // Listener in constructor will handle _user update and notify
  }
}