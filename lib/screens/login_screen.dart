import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigstartai/auth_service.dart';
import 'package:provider/provider.dart';
import 'registration_selection_screen.dart'; // Create next

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 10),
            TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(
             onPressed: () async {
  final authService = Provider.of<AuthService>(context, listen: false);
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();
  if (email.isNotEmpty && password.isNotEmpty) {
    User? user = await authService.signIn(email, password);
    if (user == null && context.mounted) { // Check if context is still valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed')),
      );
    }
    // AuthGate will handle navigation if successful
  }
},
child: Text('Login'),    
),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegistrationSelectionScreen()));
              },
              child: Text('Need an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}