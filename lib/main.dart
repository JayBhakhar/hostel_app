import 'package:flutter/material.dart';
import 'package:hostel_app/all_user.dart';
import 'package:http/http.dart' as http;
import 'package:hostel_app/registration.dart';
import 'package:hostel_app/login.dart';
import 'package:hostel_app/loading_screen.dart';
import 'package:hostel_app/profile_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // body: LoadingScreen(),
        body: All_User(),
      ),
      routes: {
        Profile_Screen.id: (context) => Profile_Screen(),
        LoginPage.id: (context) => LoginPage(),
        Profile_Screen.id: (context) => Profile_Screen(),
        Registration.id: (context) => Registration(),
        LoadingScreen.id: (context) => LoadingScreen(),
        All_User.id: (context) => All_User(),
      },
    );
  }
}
