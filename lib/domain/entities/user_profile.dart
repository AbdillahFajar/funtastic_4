class UserProfile{
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

  factory UserProfile.fromMap(Map<String, dynamic> map) {
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
      uid: map['uid'] as String,
      email: map['email'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      photoUrl: map['photoUrl'] as String?,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}