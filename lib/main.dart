import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hostel_app/registration.dart';
import 'package:hostel_app/login.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

Future Getdata(url) async {
  http.Response Response = await http.get(url);
  return Response.body;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url = 'http://192.168.137.1:5000/';
  String NameText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Registration(),
      ),
    );
  }
}
