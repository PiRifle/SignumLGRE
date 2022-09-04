import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nsd/nsd.dart';
import 'package:signum_lgre/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseServer extends StatefulWidget {
  const ChooseServer({Key? key, required this.dio}) : super(key: key);
  final Dio dio;
  @override
  State<ChooseServer> createState() => _ChooseServerState();
}



class _ChooseServerState extends State<ChooseServer> {
  List<Service> services = [];
  Future<void> discover() async {
    print("starting discovery");
    final discovery = await startDiscovery('_http._tcp', ipLookupType: IpLookupType.any);
    discovery.addListener(() {
      setState(() {
        services = [];
        discovery.services.forEach((element) {
          if (element.name == "SignumLBRI-server") services.add(element);
        });
      });
      print(discovery.services);
      discovery.services.forEach((e) {
        print("name: " + e.name.toString());
        print("type: " + e.type.toString());
        print("host: " + e.host.toString());
        print("port: " + e.port.toString());
      });

    });
  }
  Future<void> _loadServer() async {
    Dio dio = widget.dio;
    final prefs = await SharedPreferences.getInstance();
    String? host = prefs.getString('host');
    if(host != null){
      if(await checkServer(host)){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(host: host, dio: dio)),
        );
      }else{
        discover();
      }
    }else{
      discover();
    }
  }
  Future<bool> checkServer(String host) async {
    Dio dio = widget.dio;
    try{
      var firstResponse = await dio.get('http://$host:3000/app/ping');
      return firstResponse.statusCode == 200;
    }catch(_){
      return false;
    }

  }
  @override
  initState() {
    super.initState();
    _loadServer();
    // discover();
  }

  @override
  Widget build(BuildContext context) {
    Dio dio = widget.dio;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Your Data Provider"),
      ),
      body:Container(
        child:Column(children: [
          Text("Searching for servers"),
          Flexible(child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (BuildContext ctxt, int index){
              return ServerInstance(service: services[index], checkServer: checkServer, dio: dio);
            },
          ))

        ],)
      )
    );
  }
}

class ServerInstance extends StatelessWidget {
  const ServerInstance({Key? key, required this.service, required this.checkServer, required this.dio}) : super(key: key);
  final Service service;
  final Dio dio;
  final Future<bool> Function(String) checkServer;
  @override
  Widget build(BuildContext context){
    return Material(
      child:InkWell(
        onTap: () async {
          if(await checkServer(service.host.toString())){
            final prefs = await SharedPreferences.getInstance();
            prefs.setString("host", service.host.toString());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(host: service.host.toString(), dio: dio)),
            );
          }else{
            Fluttertoast.showToast(
              msg: "Cant Access Server",
            );
          };

        },
        child: Ink(
          height: 70,
          color: Colors.white,
          child: Center(child: Text('${service.name}: ${service.host}')),
        ),
      ),
    );
  }
}