import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logining/home_screen/home_screen.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Container(
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    child: Image.asset(
                      'images/logo.png',
                      width: 90,
                      height: 90,
                    ),
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 40),
                  ),
                    Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 50, 10),
                    child: TextFormField(
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Provide an Email';
                        }
                      },
                      style: TextStyle(
                        color: Color(0xFF01579B),
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Enter your Email',
                          labelText: "Email",
                          icon: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Icon(Icons.email),
                          )),
                      onSaved: (email) => _email = email,
                    ),
                  ),
Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 50, 10),
                    child: TextFormField(
                      validator: (password) {
                        if (password.isEmpty) {
                          return 'Provide an password';
                        }
                      },
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
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            semanticLabel: _obscureText
                                ? 'show password'
                                : 'hide password',
                          ),
                        ),
                      ),
                      onSaved: (password) => _password = password,
                    ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: RaisedButton(
                            color: Color(0xFFD50000),
                            textColor: Color(0xFFFFFFFF),
                            child: Text('Login with Google'),
                            onPressed:(){ _signInGoogle().then((FirebaseUser user){
                              print(user);
                            }).catchError((onError){
                              print(onError);
                            });

                            }
                          ),

                        ),
                    Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: RaisedButton(
                            color: Color(0xFF448AFF),
                            textColor: Color(0xFFFFFFFF),
                            child: Text('Login'),
                            onPressed: ()async{
                              signIn();
                              sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.setString("email", _email);
                            }),
                        ),
                   
                    
                      ]),
                    Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: FlatButton(
                            textColor: Color(0xFF448AFF),
                            child: Text('Forgot Password'),
                            onPressed: () {
                              print('onPressed');
                            },
                          ),
                        ),
                        Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 45, 0, 10),
                        child: Text(
                          'Still do not have an account ',
                          style: TextStyle(color: Color(0xFF9E9E9E)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 45, 30, 10),
                        child: FlatButton(
                          textColor: Color(0xFF448AFF),
                          child: Text('registration'),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/registration', (Route<dynamic> route) => false);
                          }))]),]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacementNamed('/list'); 
      }catch(e){
        print(e.message);
      }
    }
  }

  Future<FirebaseUser> _signInGoogle() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSa =await googleSignInAccount.authentication;

    await _auth.signInWithGoogle(
      idToken: gSa.idToken,
      accessToken: gSa.accessToken
    );
    return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}



