import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logining/login_screen/login_screen.dart';
import 'package:logining/home_screen/home_screen.dart';

class CheckStatus extends StatefulWidget {
  @override
  CheckStatusState createState() => CheckStatusState();
}

class CheckStatusState extends State<CheckStatus> {
  SharedPreferences sharedPreferences;
  String value;

  @override
  void initState() {
    super.initState();
    user();
  }

  user() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getString("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}