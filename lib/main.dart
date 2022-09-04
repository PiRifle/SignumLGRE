import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nsd/nsd.dart';

import 'chooseServer.dart';
import 'mainScreen.dart';


void main() {
  Dio dio =  Dio(BaseOptions(
      connectTimeout: 10000,  // in ms
      receiveTimeout: 10000,
      sendTimeout: 10000,
      responseType: ResponseType.plain,
      followRedirects: false,
      validateStatus: (status) { return true; }
  ));
  dio.interceptors.add(CookieManager(CookieJar()));

  runApp(MyApp(dio: dio));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.dio}) : super(key: key);
  final Dio dio;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignumLGRE',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // home: const MyHomePage(title: 'SignumLGRE'),
      home: ChooseServer(dio: dio),
    );
  }
}

