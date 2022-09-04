import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:nsd/nsd.dart';
import 'package:signum_lgre/addBook.dart';

import 'models/bookListing.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.host, required this.dio}) : super(key: key);
  final Dio dio;
  final String host;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  List<BookListing> fetchedBooks = [];
  @override
  initState() {
    _fetchBooks();
    super.initState();
  }
  Future<dynamic> _fetchBooks() async {
    Dio dio = widget.dio;
    Response<String> request = await dio.get('http://${widget.host}:3000/app/list');
    setState(() {
      fetchedBooks = (jsonDecode(request.data.toString()) as List<dynamic>).map((e) => BookListing.fromJson(e)).toList();
    });
    // print(widget.fetchedBooks);
  }
  void _incrementCounter() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBook()),
    );
    // setState(() {
    // });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Books"),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(child: 
            ListView.builder(
              itemCount: fetchedBooks.length,
              itemBuilder: (BuildContext ctxt, int index){
                return BookWidget(bookListing: fetchedBooks[index]);
              }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchBooks,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookWidget extends StatelessWidget{
  BookWidget({Key? key, required this.bookListing}) : super(key: key);
  final BookListing bookListing;

  @override
  Widget build(BuildContext context){
    Image fetchedImage = Image.memory(Base64Codec().decode(bookListing.book.image.split(",").last));
    return Container(
      child: Row(children: [
        Image(image: fetchedImage.image),
        Flexible(
          child:
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                textBaseline: TextBaseline.alphabetic,
                textDirection: TextDirection.ltr,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(bookListing.id,textAlign: TextAlign.left),
                  SizedBox(height: 10),
                  Text(bookListing.book.title,textAlign: TextAlign.left),
                  SizedBox(height: 10),
                  Text('${bookListing.commission+bookListing.cost}',textAlign: TextAlign.left),
                  SizedBox(height: 10),
                  Text(bookListing.sold ? "Sold" : "Available",textAlign: TextAlign.left),
                  // Text(bookListing./**/ ? "Sold" : "Available"),
                ],
              ),)

        )

      ],
      ),
    );
  }
}