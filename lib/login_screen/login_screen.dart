import 'package:flutter/material.dart';
import 'dart:async';
import 'package:logining/login_screen/login.dart';
import 'package:logining/login_screen/pass.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        resizeToAvoidBottomPadding: false,
        body: ListView(children: <Widget>[
          Container(
            child: Form(
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    child: Image.asset(
                      'images/logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 40),
                  ),
                  LoginTextField(),
                  PassTextField(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: FlatButton(
                            textColor: Color(0xFF448AFF),
                            child: const Text('Forgot Password'),
                            onPressed: () {
                              print('onPressed');
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: RaisedButton(
                            color: Color(0xFF448AFF),
                            textColor: Color(0xB3FFFFFF),
                            child: const Text('Login'),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 160,
                                      height: 150,
                                    ),
                                    CircularProgressIndicator(
                                      strokeWidth: 5,
                                    ),
                                  ],
                                ),
                              );
                              await Future.delayed(Duration(seconds: 0), () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/list', (Route<dynamic> route) => false);
                              });
                            },
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 110, 0, 10),
                        child: Text(
                          'Still do not have an account ',
                          style: TextStyle(color: Color(0xFF9E9E9E)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 110, 30, 10),
                        child: FlatButton(
                          textColor: Color(0xFF448AFF),
                          child: const Text('registration'),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/bs', (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
