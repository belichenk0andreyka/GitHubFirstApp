import 'package:flutter/material.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {

  @override
  LoginScreenState createState() {
    return  LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {

bool _obscureText = true;


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home:  Scaffold(
        appBar: AppBar(
         title: Text('Login'),
       ),
       resizeToAvoidBottomPadding: false,
       body: Column(
           children: [
             SizedBox(height: 50,),
             Padding(
               child: Image.asset(               
                 'images/logo.png',
                 width: 100.0,
                 height: 100.0,
               ),
               padding: EdgeInsets.fromLTRB(50, 0, 50, 40),
             ),

              Padding(
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
                   )
                   ),
                 ),
               ),
             
             
             Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 50, 10),
                child: TextFormField(
                      obscureText: _obscureText,
                style: TextStyle(
                      color: Color(0xFF01579B),
                      fontSize: 18.0,
                    ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30), 
                  ),
                  hintText: 'Enter your password',
                  labelText: "Password",
                  icon: Padding(
                    padding: EdgeInsets.only(top: 15.0), 
                    child: Icon(Icons.lock),
                    ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                        });
                      },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      semanticLabel: _obscureText ? 'show password' : 'hide password',
                    ),
                  ),
                ),
              ),
              ),
             
               
               Row( 
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      await Future.delayed(Duration(seconds: 3), () {
                     Navigator.of(context).pushNamedAndRemoveUntil('/list', (Route<dynamic> route) => false);
                        });
                       },
                      ),
                   ),
                   ]
                 ),
       
                  
                  
                  Row( 
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 110, 0, 10),
                    child: Text('Still do not have an account ' ,
                    style: TextStyle( color: Color(0xFF9E9E9E)),
                    ),
                  ),
                  Padding(
                     padding: EdgeInsets.fromLTRB(0, 110, 30, 10),
                     child: FlatButton(
                       textColor: Color(0xFF448AFF),
                       child: const Text('registration'),
                       onPressed: () {
                         print('onPressed');
                       },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    
   );
 }
}