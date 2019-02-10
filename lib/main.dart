import 'package:flutter/material.dart';
import 'package:logining/home_screen/home_screen.dart';
import 'package:logining/login_screen/login_screen.dart';
import 'package:logining/account_screen/account_screen.dart';
import 'package:logining/login_screen/registration.dart';
import 'package:logining/home_screen/about_us.dart';
import 'package:logining/varification.dart';

void main() {
  runApp(MaterialApp(
    title: 'Login',
    home: CheckStatus(),
    routes: <String, WidgetBuilder>{
      '/list': (_) => HomeScreen(),
      '/login': (_) => LoginScreen(),
      '/avatar': (_) => AccountScreen(),
      '/about': (_) => AboutUs(),
      '/registration': (_) => RegistrationScreen()
    },
  ));
}
