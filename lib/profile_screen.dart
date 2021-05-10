import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/login.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'package:hostel_app/user_detail_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Screen extends StatefulWidget {
  static String id = 'profile_screen';
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

  void initState() {
    super.initState();
    GetUserData(url);
  }

  Future<void> sign_out() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<http.Response> GetUserData(url) async {
    final url = Uri.parse('http://192.168.137.1:5000/users');
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> header = {
      "x-access-token": prefs.getString('token'),
    };
    http.Response response = await http.get(url, headers: header);
    json.decode(response.body);
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
      if (hostel_no == 'Общежитие №. 1 (Деповская, 27)') {
        return hostel_no = '1';
      } else if (hostel_no == 'Общежитие №. 2 (проспект Ленина, 29)') {
        return hostel_no = '2';
      } else if (hostel_no == 'Общежитие №. 3 (проспект Ленина, 35)') {
        return hostel_no = '3';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            sign_out();
            print('remove token');
            Navigator.pushReplacementNamed(
              context,
              LoginPage.id,
            );
          },
        ),
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // for (var user in userMap) Text(user['name']),
          UserDetailCard(
            full_name: '$name $surename',
            room_no: room_no,
            hostel_no: '$hostel_no',
          ),
        ],
      ),
    );
  }
}
