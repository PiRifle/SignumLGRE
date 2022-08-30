import 'dart:ffi';

class Book {
  final String title;
  final int isbn;
  final List<String> authors;
  final String publisher;
  final int pubDate;
  final double msrp;
  final String image;

  const Book({
    required this.title,
    required this.isbn,
    required this.authors,
    required this.publisher,
    required this.pubDate,
    required this.msrp,
    required this.image,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json["title"],
      isbn: json["isbn"],
      // authors: ["aa"],
      authors: List<String>.from(json["authors"]),
      publisher: json["publisher"],
      pubDate: json["pubDate"],
      msrp: json["msrp"],
      image: json["image"],
    );
  }
}