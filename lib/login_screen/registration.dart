import 'package:flutter/material.dart';
// import 'package:firebase_showcase/login_screen/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logining/login_screen/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
        ),
        resizeToAvoidBottomPadding: false,
        body: ListView(children: <Widget>[
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
                      child: Text('Registration Window',
                      style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                         
                      ),
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
                        ),
                        onSaved: (password) => _password = password,
                      ),
                    ),
                    
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: RaisedButton(
                              color: Color(0xFF448AFF),
                              textColor: Color(0xB3FFFFFF),
                              child:  Text('Login'),
                              onPressed: signUp,
                            ),
                          ),
                        
                    
                  ],
                ),
              ),
            ),
          ]),
        ),
    );
  }

 void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }catch(e){
        print(e.message);
      }
    }
  }
}
