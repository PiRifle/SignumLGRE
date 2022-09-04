import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mainScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, required this.host, required this.dio}) : super(key: key);
  final String host;
  final Dio dio;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override


  Future<void> _login(BuildContext context) async {
    print('email ${emailController.text}');
    print('password ${passwordController.text}');

     var loginResponse = await dio.post(
         'http://$host:3000/app/login',
        data:{
              'email': emailController.text,
              'password': passwordController.text,
            }
        ,
       options: Options(contentType: Headers.formUrlEncodedContentType),
     );
     if(loginResponse.statusCode == 200){
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => MyHomePage(host: host,dio: dio)),
       );
     }
  }

  void init() async {

  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to provider"),
      ),
      body: Container(
        margin: EdgeInsets.all(40),
        child: Center(child:
          Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: "Provide your E-Mail address",
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: "Provide your Password",
                ),
              ),
              SizedBox(height: 20,),
              OutlinedButton(
                  onPressed: (){_login(context);},
                  child: Text("Login")
              )
            ],
          ),
        ),
      ),
    );
  }
}