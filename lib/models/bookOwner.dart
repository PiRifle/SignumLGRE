import 'dart:ffi';

class BookOwner {
  final String name;
  final String surname;
  final String email;
  final String phone;

  const BookOwner({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
  });

  factory BookOwner.fromJson(Map<String, dynamic> json) {
    return BookOwner(
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      phone: json["phone"]
    );
  }
}