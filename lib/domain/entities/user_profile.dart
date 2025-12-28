class UserProfile {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.createdAt,
    this.updatedAt,
  });

  // Method copyWith dipakai untuk menerapkan pembaruan email dengan cara yang best practice
  // UserProfile copyWith({
  //   String? uid,
  //   String? email,
  //   String? displayName,
  //   String? photoUrl,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) {
  //   return UserProfile(
  //     uid: uid ?? this.uid,
  //     email: email ?? this.email,
  //     displayName: displayName ?? this.displayName,
  //     photoUrl: photoUrl ?? this.photoUrl,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //   );
  // }

  factory UserProfile.fromMap(String uid, Map<String, dynamic> map) {
    final created = map['createdAt'];
    final updated = map['updatedAt'];
    DateTime createdAt;
    DateTime? updatedAt;
    if (created is int) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(created, isUtc: true).toLocal();
    } else if (created is DateTime) {
      createdAt = created;
    } else {
      createdAt = DateTime.now();
    }
    if (updated is int) {
      updatedAt = DateTime.fromMillisecondsSinceEpoch(updated, isUtc: true).toLocal();
    } else if (updated is DateTime) {
      updatedAt = updated;
    } else {
      updatedAt = null;
    }
    return UserProfile(
      uid: uid, //bikin uid yang bukan lagi mapping manual, tapi diambil dari firestore database
      email: map['email'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      photoUrl: map['photoUrl'] as String?,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}