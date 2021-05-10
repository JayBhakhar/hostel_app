import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/login.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'package:hostel_app/user_detail_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class All_User extends StatefulWidget {
  static String id = 'all_user';
  @override
  _All_UserState createState() => _All_UserState();
}

class _All_UserState extends State<All_User> {
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
  List<dynamic> users;

  void initState() {
    super.initState();
    GetAllUserData(url);
  }

  Future<http.Response> GetAllUserData(url) async {
    final url = Uri.parse('http://192.168.137.1:5000/all_users');
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> header = {
      "x-access-token": prefs.getString('token'),
    };
    http.Response response = await http.get(url, headers: header);
    json.decode(response.body);
    setState(() {
      var userMap = json.decode(response.body);
      users = userMap["users"];
      print(users);
      // name = userMap['users'][listInt]['name'];
      // surename = userMap['users'][listInt]['surename'];
      // fathername = userMap['users'][listInt]['fatherName'];
      // faculty = userMap['users'][listInt]['faculty'];
      // course = userMap['users'][listInt]['course'];
      // group = userMap['users'][listInt]['group'];
      // phone_no = userMap['users'][listInt]['phoneNo'];
      // email = userMap['users'][listInt]['email'];
      // hostel_no = userMap['users'][listInt]['hostelNo'];
      // room_no = userMap['users'][listInt]['roomNo'];
      // position = userMap['users'][listInt]['position'];
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
      appBar: AppBar(title: Text('ALL USERS'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
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
          for (var user in users)
            UserDetailCard(
              // full_name: '$name $surename',
              full_name: user['name'] + ' ' + user['surename'],
              room_no: user['roomNo'],
              hostel_no: user['hostelNo'],
            ),
        ],
      ),
    );
  }
}
