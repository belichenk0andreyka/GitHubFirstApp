import 'package:flutter/material.dart';
import 'package:logining/home_screen/home_screen.dart';
import 'package:logining/login_screen/login_screen.dart';
import 'package:logining/account_screen/account_screen.dart';
import 'package:logining/home_screen/about_us.dart';

void main() {
  runApp(MaterialApp(
    title: 'Login',
    home: LoginScreen(),
    routes: <String, WidgetBuilder>{
      '/list': (_) => HomeScreen(),
      '/login': (_) => LoginScreen(),
      '/avatar': (_) => AccountScreen(),
      '/about': (_) => AboutUs(),
    },
  ));
}
