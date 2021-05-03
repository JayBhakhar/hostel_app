import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String surename;
  String name;
  String fathername;
  String faculty;
  String course;
  String group;
  String phone_no;
  String email;
  String hostel_no;
  String room_no;
  String position;
  void initState() {
    super.initState();
    GetUserData(url);
  }

  Future<http.Response> GetUserData(url) async {
    http.Response response = await http.get(url);
    setState(() {
      var userMap = json.decode(response.body);
      name = userMap['user'][0]['name'];
      surename = userMap['user'][0]['surename'];
      name = userMap['user'][0]['name'];
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
