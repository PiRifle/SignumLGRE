import 'dart:ffi';

class User {
  final String email;
  final String name;

  const User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }
}