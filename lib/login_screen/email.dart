import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 50, 10),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xFF01579B),
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: 'Enter your login',
            labelText: "Login",
            icon: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.email),
            )),
      ),
    );
  }
}
