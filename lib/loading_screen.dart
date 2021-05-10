import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hostel_app/profile_screen.dart';
import 'package:hostel_app/user_detail_card.dart';
import 'package:hostel_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  static String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _makePath();
  }

  void _makePath() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      });
    } else {
      Navigator.pushReplacementNamed(context, Profile_Screen.id);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.blueAccent,
          size: 100.0,
        ),
      ),
    );
  }
}
