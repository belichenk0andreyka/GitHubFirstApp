import 'dart:io';
import 'package:logining/account_screen/button_countries.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String imagePath = 'images/user.png';

class AccountScreen extends StatefulWidget {
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<Null> imageSelectorGallery() async {
    final File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (imageFile != null) imagePath = imageFile.path;
    });
  }

  Future<Null> imageSelectorCamera() async {
    final File imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (imageFile != null) imagePath = imageFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AvatarScreen'),
        ),
        resizeToAvoidBottomPadding: false,
        body: ListView(children: <Widget>[
          Container(
            child: Form(
              autovalidate: true,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                IconButton(
                    iconSize: 150,
                    icon: CircleAvatar(
                      backgroundImage: AssetImage(imagePath),
                      radius: 150,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('Choise a method to save a image'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Make a photo'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      imageSelectorCamera();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Photo from gallery'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      imageSelectorGallery();
                                    },
                                  ),
                                ],
                              ));
                    }),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextFormField(
              style: TextStyle(
                color: Color(0xFF01579B),
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Enter your Email',
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextFormField(
              style: TextStyle(
                color: Color(0xFF01579B),
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Your name',
                labelText: 'Name',
              ),
            ),
          ),
          Row(
           children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 1, 5), child: DropDown(),
              ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 5, 5, 5),
            child: RaisedButton(
              color: Color(0xFF448AFF),
              textColor: Color(0xFFFFFFFF),
              child: const Text('Save'),
              onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                  '/list', (Route<dynamic> route) => false);
              },
            ),
          ),
        ]),]),
      ),
    );
  }
}
