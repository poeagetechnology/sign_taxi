// import 'package:cloud_firestore/cloud_firestore.dart'; // Add this if you want to keep fromFirestore

class UserModel {
  final String uid;
  final String name;
  final String? email;
  final String? phone;
  String role;
  final String? profilePicUrl;
  bool isOnboardingComplete;

  UserModel({
    required this.uid,
    required this.name,
    this.email,
    this.phone,
    this.role = 'passenger',
    this.profilePicUrl,
    this.isOnboardingComplete = false,
  });

  // Temporarily comment out until cloud_firestore is fully set up
  // factory UserModel.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return UserModel(
  //     uid: doc.id,
  //     name: data['name'] ?? '',
  //     email: data['email'],
  //     phone: data['phone'],
  //     role: data['role'] ?? 'passenger',
  //     profilePicUrl: data['profilePicUrl'],
  //     isOnboardingComplete: data['isOnboardingComplete'] ?? false,
  //   );
  // }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? profilePicUrl,
    bool? isOnboardingComplete,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
    );
  }
}