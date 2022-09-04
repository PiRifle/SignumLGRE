import 'dart:ffi';

import 'package:signum_lgre/models/book.dart';
import 'package:signum_lgre/models/user.dart';

import 'bookOwner.dart';

class BookListing {
  final String id;
  final Book book;
  final BookOwner bookOwner;
  final double commission;
  final double cost;
  final bool sold;
  final User putOnSaleBy;
  final User soldBy;

  const BookListing({
    required this.id,
    required this.book,
    required this.bookOwner,
    required this.commission,
    required this.cost,
    required this.putOnSaleBy,
    required this.sold,
    required this.soldBy
  });

  factory BookListing.fromJson(Map<String, dynamic> json) {

    return BookListing(
      id: json["_id"],
      book: Book.fromJson(json["book"]),
      bookOwner: BookOwner.fromJson(json["bookOwner"]),
      commission: json["commission"].toDouble(),
      cost: json["cost"].toDouble(),
      putOnSaleBy: User.fromJson(json["putOnSaleBy"]),
      sold: json["sold"]!=null ? json["sold"] : false,
      soldBy: json["soldBy"]!=null ? User.fromJson(json["soldBy"]) : const User(name: "", email: "")
    );
  }
}