import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hostel_app/login.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';

class Profile_Screen extends StatefulWidget {
  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  String surename;
  String name;
  String fathername;
  String faculty;
  String course;
  String group;
  int phone_no;
  String email;
  String hostel_no;
  int room_no;
  String position;
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI0YjkxNzc3OC0zN2M3LTQwMjAtYTdmMS1lOGJkNjIyNTIzYzIiLCJleHAiOjE2MjAwODQ0MjJ9.rAmRlJCCjRxxTgwUj3rqhMtZXVpmkOpH69Iprwgo5hE";
  // token kei rite login mathi ahi lavavu
  // push with navigator
  void initState() {
    super.initState();
    GetUserData(url);
  }

  Future<http.Response> GetUserData(url) async {
    final url = Uri.parse('http://192.168.137.1:5000/users');
    Map<String, String> header = {
      "x-access-token": "$token",
    };
    http.Response response = await http.get(url, headers: header);
    setState(() {
      var userMap = json.decode(response.body);
      name = userMap['user'][0]['name'];
      surename = userMap['user'][0]['surename'];
      fathername = userMap['user'][0]['fatherName'];
      faculty = userMap['user'][0]['faculty'];
      course = userMap['user'][0]['course'];
      group = userMap['user'][0]['group'];
      phone_no = userMap['user'][0]['phoneNo'];
      email = userMap['user'][0]['email'];
      hostel_no = userMap['user'][0]['hostelNo'];
      room_no = userMap['user'][0]['roomNo'];
      position = userMap['user'][0]['position'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: Image.asset('images/jay.jpg'),
            ),
            Text('$surename $name $fathername'),
            Text('$faculty'),
            Text('$course'),
            Text('$group'),
            Text('$phone_no'),
            Text('$email'),
            Text('$hostel_no'),
            Text('$room_no'),
            Text('$position'),
          ],
        ),
      ),
    );
  }
}

// class NetworkHelper {
//   NetworkHelper(this.url);
//
//   final String url;
//
//   Future getData() async {
//     http.Response response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       String data = response.body;
//
//       return jsonDecode(data);
//     } else {
//       print(response.statusCode);
//     }
//   }
// }
//
// class WeatherModel {
//   Future<dynamic> getCityWeather(String cityName) async {
//     NetworkHelper networkHelper = NetworkHelper(
//         '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
//
//     var weatherData = await networkHelper.getData();
//     return weatherData;
//   }
