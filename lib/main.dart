import 'package:flutter/material.dart';
import 'dart:async';


void main() {
  runApp(new MaterialApp(
  title: 'Login',
  home: FirstScreen(),
    routes: <String, WidgetBuilder> {
         '/list': (_) => new SecondScreen(items: <String>[],),
         '/login': (_) => new FirstScreen(),
       },
  ));
}


class FirstScreen extends StatefulWidget {

  @override
  FirstScreenState createState() {
    return new FirstScreenState();
  }
}

class FirstScreenState extends State<FirstScreen> {

bool _obscureText = true;


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: new Scaffold(
        appBar: AppBar(
         title: Text('Login'),
       ),
       resizeToAvoidBottomPadding: false,
       body: Column(
           children: [
             SizedBox(height: 50,),
             Padding(
               child: new Image.asset(               
                 'images/logo.png',
                 width: 100.0,
                 height: 100.0,
               ),
               padding: EdgeInsets.fromLTRB(50, 0, 50, 40),
             ),

              Padding(
               padding: EdgeInsets.fromLTRB(25, 0, 50, 10),
                 child: new TextFormField(
                   style: TextStyle(
                     color: Color(0xFF01579B),
                     fontSize: 18.0,
                     ),
                 decoration: new InputDecoration(
                   border: new OutlineInputBorder(
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
                child: new TextFormField(
                      obscureText: _obscureText,
                style: TextStyle(
                      color: Color(0xFF01579B),
                      fontSize: 18.0,
                    ),
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
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
                            child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 160,
                                height: 150,
                              ),
                          new CircularProgressIndicator(
                            strokeWidth: 5,
                          ),
                        ],
                      ),
                    );
                      await Future.delayed(new Duration(seconds: 3), () {
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

    class SecondScreen extends StatelessWidget{
      
      final List<String> items;

       SecondScreen({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
         title: Text('flutter'),
         actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.share),
             tooltip: 'Action Tool Tip', 
             onPressed: () {
               print("onPressed");
             }
           ),
          new IconButton(
            icon: new Icon(Icons.exit_to_app),
            tooltip: 'Action Tool Tip',
            onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              }),
            ]
       ),
       body: ListView.separated(
         itemCount: 25,
         separatorBuilder: (BuildContext context, int index) => Divider(),
         itemBuilder: (BuildContext context, int index) {
           return ListTile(
           leading: const Icon(Icons.account_circle),
           title: const Text('Example title'),
           subtitle: const Text('Example subtitle'),
           trailing: Icon(Icons.keyboard_arrow_right),
          );
         },
        ),
      );
    
}
}
