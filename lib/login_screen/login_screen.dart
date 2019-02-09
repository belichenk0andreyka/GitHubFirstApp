import 'package:flutter/material.dart';
import 'package:logining/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}
enum LoginStatus{
  notSignIn,
  signIn,
}

class LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  var _email, _password;
  bool _obscureText = true;




  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  SharedPreferences sharedPreferences;


  savePref()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   setState((){
     preferences.setString('email', _email);
     preferences.setString('password', _password);
     preferences.commit();
   }); 
  }
  var value;
  getPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getString("email");
      value = preferences.getString("password");

      _loginStatus = value == null ? LoginStatus.notSignIn : LoginStatus.signIn;
    });
  }
  @override
  void initState(){
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch(_loginStatus){
      case LoginStatus.notSignIn:
        return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
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
                      controller: email,
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
                      controller: password,
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
                            onPressed: signIn,
                          ),
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
                        padding: EdgeInsets.fromLTRB(50, 70, 0, 10),
                        child: Text(
                          'Still do not have an account ',
                          style: TextStyle(color: Color(0xFF9E9E9E)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 70, 30, 10),
                        child: FlatButton(
                          textColor: Color(0xFF448AFF),
                          child: Text('registration'),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/registration', (Route<dynamic> route) => false);
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
      );
        break;
      case LoginStatus.signIn:
        return HomeScreen();
        break;
    }
    
  }
Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password); 
        
       _loginStatus = LoginStatus.signIn;
      //  savePref();
       Navigator.of(context).pushNamedAndRemoveUntil(
                  '/list', (Route<dynamic> route) => false);
      }catch(e){
        print(e.message);
      }
    }
}
Future<FirebaseUser> _signInGoogle() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSa =await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: gSa.idToken,
      accessToken: gSa.accessToken
      );
      print('User Name : ${user.displayName}');
      return Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
  }
}
// void signIn() async {
//     if(_formKey.currentState.validate()){
//       _formKey.currentState.save();
//       try{
//         FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         pref.setString("email", _email);
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
//       }catch(e){
//         print(e.message);
//       }
//     }
//   }