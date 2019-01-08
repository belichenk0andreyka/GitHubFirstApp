import 'package:flutter/material.dart';
import 'package:logining/home_screen.dart';
import 'package:logining/login_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Login',
    home: LoginScreen(),
    routes: <String, WidgetBuilder>{
      '/list': (_) => HomeScreen(
          ),
      '/login': (_) => LoginScreen(),
    },
  ));
}
