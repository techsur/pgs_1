class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final DateTime? dateOfBirth;
  final String? address;
  final String? qualification;
  final DateTime createdAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final List<String> enrolledCourses;
  final Map<String, dynamic>? preferences;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.dateOfBirth,
    this.address,
    this.qualification,
    required this.createdAt,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.enrolledCourses = const [],
    this.preferences,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profileImage'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      address: json['address'],
      qualification: json['qualification'],
      createdAt: DateTime.parse(json['createdAt']),
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      enrolledCourses: List<String>.from(json['enrolledCourses'] ?? []),
      preferences: json['preferences'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'address': address,
      'qualification': qualification,
      'createdAt': createdAt.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'enrolledCourses': enrolledCourses,
      'preferences': preferences,
    };
  }
}