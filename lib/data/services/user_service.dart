import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile.dart';

//ambil data dari collection users di firestore database
class UserService {
  Stream<UserProfile> userStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) {
          final data = doc.data();
          if (data == null) {
            throw Exception('User document does not exist');
          }
          return UserProfile.fromMap(doc.id, data);
        });
  }
}
