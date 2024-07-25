import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> storeUserInfo(String firstName) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'firstName': firstName,
        'email': user.email,
        // Add other fields as needed
      });
    }
  }

  Future<Map<String, dynamic>?> fetchUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(user.uid).get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      }
    }
    return null;
  }
}
