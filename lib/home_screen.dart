import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
   
   final List<String> items;
  

       HomeScreen({Key key, @required this.items, }) : super(key: key);
}
 class HomeScreenState extends State<HomeScreen> {     

 List data;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://api.myjson.com/bins/8jxuc"),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = json.decode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
         title: Text('flutter'),
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.share),
             tooltip: 'Action Tool Tip', 
             onPressed: () {
               print("onPressed");
             }
           ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Action Tool Tip',
            onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              }),
            ]
       ),
       body: FutureBuilder(
  future: getData(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
         itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(data[index]["title"]),
            subtitle: Text(data[index]["subtitle"]),

          );
        },
        );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return Row(
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
        );
        },
      ),
      );
    }
}
