import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserData({
    required String uid,
    required String email,
    required String name, // Name or Business Name
    required String skills, // Comma-separated skills or skills needed
    required String userType, // 'youth' or 'business'
  }) async {
    // Use uid as document ID for easy lookup
    final docRef = _db.collection(userType == 'youth' ? 'users' : 'businesses').doc(uid);
    await docRef.set({
      'uid': uid,
      'email': email,
      'name': name,
      'skills': skills, // Save as raw string for speed
      'userType': userType,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
   // Basic function to get potential matches (VERY basic)
   Future<List<QueryDocumentSnapshot>> getMatches(String currentUserType, List<String> userSkills) async {
     if (userSkills.isEmpty) return [];

     final targetCollection = currentUserType == 'youth' ? 'businesses' : 'users';
     final skillFieldName = currentUserType == 'youth' ? 'skillsNeeded' : 'skills'; // Assuming field name is 'skills' or 'skillsNeeded'

     // --- SUPER SIMPLIFIED MATCHING ---
     // Get ALL documents from the opposite collection and filter client-side

     try {
       QuerySnapshot snapshot = await _db.collection(targetCollection).get();
       List<QueryDocumentSnapshot> matches = [];

       // This is where the "AI" would normally go.
       // Simple keyword check for prototype:
       for (var doc in snapshot.docs) {
         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
         String targetSkillsString = data['skills'] ?? ''; // Use 'skills' for both for simplicity now
         List<String> targetSkills = targetSkillsString.split(',').map((s) => s.trim().toLowerCase()).toList();
         List<String> searchSkills = userSkills.map((s) => s.trim().toLowerCase()).toList();

         // Check if any skill overlaps
         bool foundMatch = searchSkills.any((skill) => targetSkills.contains(skill));
         if (foundMatch) {
           matches.add(doc);
         }
       }
       print("Found ${matches.length} potential matches.");
       return matches;

     } catch (e) {
        print("Error getting matches: $e");
        return [];
     }
     // ------------------------------------
   }

   // Function to get current user profile
   Future<DocumentSnapshot?> getUserProfile(String uid) async {
        try {
            DocumentSnapshot userDoc = await _db.collection('users').doc(uid).get();
            if (userDoc.exists) return userDoc;
            DocumentSnapshot businessDoc = await _db.collection('businesses').doc(uid).get();
            if (businessDoc.exists) return businessDoc;
            return null; // Not found in either
        } catch (e) {
            print("Error getting user profile: $e");
            return null;
        }
    }
}