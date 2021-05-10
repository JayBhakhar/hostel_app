import 'package:flutter/material.dart';
import 'package:hostel_app/registration.dart';
import 'package:http/http.dart';
import 'package:hostel_app/profile_screen.dart';
import 'dart:convert';
import 'package:hostel_app/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  String token;

  Future<void> log_in() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('token saved');
    print(prefs.get('token'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.account_circle_sharp,
                size: 120,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: login,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 20,
                    ),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                //forgot password screen
              },
              textColor: Colors.blueAccent,
              child: Text('Forgot Password'),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blueAccent,
                child: Text('Login'),
                onPressed: () async {
                  final url = Uri.parse('http://192.168.137.1:5000/login');
                  Map<String, String> headers = {
                    "Content-type": "application/json"
                  };
                  String json = '{"email":"${login.text}",'
                      '"password":"${password.text}"}';

                  // make POST request
                  Response response =
                      await post(url, headers: headers, body: json);
                  // check the status code for the result
                  int statusCode = response.statusCode;
                  // this API passes back the id of the new item added to the body
                  String body = response.body;
                  Map<String, dynamic> userToken = jsonDecode(body);
                  token = userToken['token'];
                  log_in();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadingScreen(),
                    ),
                  );
                  // {
                  //      token or error message
                  // }
                },
              ),
            ),
            Container(
                child: Row(
              children: <Widget>[
                Text('Does not have account?'),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Registration(),
                      ),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
          ],
        ),
      ),
    );
  }
}
