
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:signum_lgre/models/book.dart';
import 'dart:convert';
class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);


  @override
  State<AddBook> createState() => _AddBookState();
}
class _AddBookState extends State<AddBook> {


  bool fetchedBook = false;
  Image fetchedImage = Image.memory(Base64Codec().decode("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7".split(',').last),height: 1,);
  Future<Book> fetchBook(String isbn) async {
    return Book(title: "title", isbn: 55, authors: ["authors"], publisher: "publisher", pubDate: 2, msrp: 3, image: "image");
    // final response = await http
    //     .get(Uri.parse('http://192.168.8.189:3000/book/fromisbn?isbn=$isbn')).timeout(const Duration(seconds: 20));
    //
    // if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Book.fromJson(jsonDecode(response.body));
    // } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // throw Exception('Failed to load album');
    // }
  }
  TextEditingController ISBNController = TextEditingController();
  TextEditingController bookNameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController commissionController = TextEditingController();

  void scan() async{
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
    ISBNController.text = barcodeScanRes;
    isbnSubmit(barcodeScanRes);
  }
  void isbnSubmit(value) async{
    Book book = await fetchBook(value);
    setState(() {
      fetchedBook = true;
    });
    bookNameController.text = book.title;
    authorController.text = book.authors.toString();
    publisherController.text = book.publisher;
    yearController.text = book.pubDate.toString();
    fetchedImage = Image.memory(Base64Codec().decode(book.image.split(",").last));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Book"),
        ),
      body: SingleChildScrollView(child: Container(
        margin: EdgeInsets.all(40),
        child:    Column(
          children: [
            Row(
              children: [Text("Book Information",  textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall,),],
            ),
            Row(children: [
              Image(image: fetchedImage.image),
              SizedBox(width: 20),
              Flexible(child:
              Column(children: [TextField(
                controller: ISBNController,
                enabled: !fetchedBook,
                keyboardType: TextInputType.number,
                onSubmitted: isbnSubmit,
                decoration: InputDecoration(
                  labelText: 'ISBN',
                  hintText: "Type in the ISBN code or scan the barcode",
                  suffixIcon: IconButton(
                    onPressed: scan,
                    icon: Icon(Icons.camera),
                  ),
                ),
              ),
                TextField(
                  enabled: !fetchedBook,
                  controller: bookNameController,
                  decoration: InputDecoration(
                    labelText: 'Book Name',
                    hintText: "Type in the name of the Book",
                  ),
                ),
                TextField(
                  enabled: !fetchedBook,
                  controller: authorController,
                  decoration: InputDecoration(
                    labelText: 'Authors',
                    hintText: "Type in the authors of the book",
                  ),
                ),
                TextField(
                  enabled: !fetchedBook,
                  controller: publisherController,
                  decoration: InputDecoration(
                    labelText: 'Publisher',
                    hintText: "Type in the publisher of the Book",
                  ),
                ),
                TextField(
                  enabled: !fetchedBook,
                  controller: yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Year',
                    hintText: "Type in the publication year of the Book",
                  ),
                ),],)
              )

            ],),
            Text("Powered By podrecznikowo.pl"),

            SizedBox(height: 20),
            Row(children: [
              Text("Seller Information", style: Theme.of(context).textTheme.headlineSmall),
              IconButton(onPressed: null, icon: Icon(Icons.contacts))
            ],),
            Row(
              children: [
              Flexible(
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              ),
                SizedBox(width: 20),
              Flexible(
                child: TextField(
                  controller: surnameController,
                  decoration: InputDecoration(
                    labelText: 'Surname',
                  ),
                ),
              ),
            ],),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            SizedBox(height: 20),
            Row(children: [
              Text("Selling Cost", style: Theme.of(context).textTheme.headlineSmall),

            ],),
            Row(
              children: [
                Flexible(child:
                  TextField(
                    controller: costController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffix: Text("zł"),
                      labelText: 'Cost',
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(child:
                  TextField(
                    controller: commissionController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffix: Text("zł"),
                      labelText: 'Commission',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),)
      )
    );
  }
}