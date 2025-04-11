import 'package:flutter/material.dart';
import 'registration_screen.dart'; // Create next

class RegistrationSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register As')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegistrationScreen(userType: 'youth')));
              },
              child: Text('Register as Youth'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => RegistrationScreen(userType: 'business')));
              },
              child: Text('Register as Business'),
            ),
          ],
        ),
      ),
    );
  }
}