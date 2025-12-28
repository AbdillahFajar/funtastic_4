import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/env.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';

class FirestoreService implements UserRepository {
  final _db = FirebaseFirestore.instance;

  @override
  Future<UserProfile?> getProfile(String uid) async {
    final doc = await _db.collection(Env.usersCollection).doc(uid).get(); //ambil document dari users collection di firebase berdasarkan uid-nya
    if (!doc.exists) return null;
    final data = doc.data()!;
    return UserProfile.fromMap(
      doc.id, //ambil uid dari document di collection users di firestore database
    {
      'email': data['email'],
      'displayName': data['displayName'],
      'photoUrl': data['photoUrl'],
      'createdAt': (data['createdAt'] is Timestamp) ? (data['createdAt'] as Timestamp).toDate() : data['createdAt'],
      'updatedAt': (data['updatedAt'] is Timestamp) ? (data['updatedAt'] as Timestamp).toDate() : data['updatedAt'],
    });
  }

  @override
  Future<void> createOrUpdateProfile(UserProfile profile) {
    return _db.collection(Env.usersCollection).doc(profile.uid).set({
      'email': profile.email,
      'displayName': profile.displayName,
      'photoUrl': profile.photoUrl,
      'createdAt': Timestamp.fromDate(profile.createdAt),
      'updatedAt': profile.updatedAt != null ? Timestamp.fromDate(profile.updatedAt!) : FieldValue.delete(),
    }, SetOptions(merge: true));
  }
}