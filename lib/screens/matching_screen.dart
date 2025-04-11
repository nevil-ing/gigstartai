import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_service.dart';
import '../firestore_service.dart';

class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  Future<List<QueryDocumentSnapshot>>? _matchesFuture;
  String? _currentUserType;
  String _userName = 'User'; // Default name

  @override
  void initState() {
    super.initState();
    // Delay fetching until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCurrentUserAndMatches());
  }

 Future<void> _loadCurrentUserAndMatches() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user != null) {
      // Fetch user profile to get type and skills
      DocumentSnapshot? profile = await _firestoreService.getUserProfile(user.uid);

      if (profile != null && profile.exists) {
        Map<String, dynamic> data = profile.data() as Map<String, dynamic>;
        setState(() {
           _currentUserType = data['userType'];
           _userName = data['name'] ?? 'User'; // Update user name
           String skillsString = data['skills'] ?? '';
           List<String> skillsList = skillsString.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

           if (_currentUserType != null && skillsList.isNotEmpty) {
              _matchesFuture = _firestoreService.getMatches(_currentUserType!, skillsList);
           } else {
              _matchesFuture = Future.value([]); // No type or skills, no matches
           }
        });
      } else {
         // Handle profile not found scenario
         setState(() {
             _matchesFuture = Future.value([]);
         });
         print("User profile not found for UID: ${user.uid}");
      }
    } else {
         // Handle user not logged in scenario
         setState(() {
             _matchesFuture = Future.value([]);
         });
    }
  }


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false); // For signout

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $_userName! Matches'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              // AuthGate will handle navigation
            },
          ),
        ],
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _matchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print("MATCHING SCREEN ERROR: ${snapshot.error}");
            return Center(child: Text('Error loading matches.'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No matches found yet.'));
          }

          // We have matches!
          final matches = snapshot.data!;
          final matchType = _currentUserType == 'youth' ? 'Business' : 'Youth';

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final matchData = matches[index].data() as Map<String, dynamic>;
              final name = matchData['name'] ?? 'N/A';
              final skills = matchData['skills'] ?? 'N/A'; // Raw skills string

              // Simple card display
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text('$matchType: $name'),
                  subtitle: Text('Skills: $skills'),
                  // TODO: Add onTap for details later
                ),
              );
            },
          );
        },
      ),
       floatingActionButton: FloatingActionButton( // Add a refresh button
         onPressed: _loadCurrentUserAndMatches,
         child: Icon(Icons.refresh),
         tooltip: 'Refresh Matches',
       ),
    );
  }
}