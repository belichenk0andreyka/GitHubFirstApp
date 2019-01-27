import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ListSports extends StatefulWidget {
  _ListSportsState createState() => _ListSportsState();
}

class _ListSportsState extends State<ListSports> {

String url = 'https://www.thesportsdb.com/api/v1/json/1/all_sports.php';
List data;

@override
void initState() {
  super.initState();
  this.getJsonData();
}

 Future<String>getJsonData() async{
  var response = await http.get(
    Uri.encodeFull(url),
    headers: {"Accept":"application/json"}
  );

  print(response.body);

  setState(() {
      var convertDatatoJson = json.decode(response.body);
      data = convertDatatoJson['sports'];
    });
    return "Success";
}


  @override
  Widget build(BuildContext context) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black
              ), 
              
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
               ListTile(
                 title: Text(data[index]['strSport']),
                  leading: Container(
                    width: 150,
                    height: 90,
                    margin: EdgeInsets.fromLTRB(5, 65, 5, 65),
                    child: Image.network(data[index]['strSportThumb']),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => SportPage(data[index]),
                      ),);
                    },
                    )],
                    ),
                    ),

                    );
          } 
    );
  }
}

class SportPage extends StatelessWidget {
  SportPage(this.data);
  final data;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title:Text(data['strSport'])
    ),
    resizeToAvoidBottomPadding: false,
    
    body:SingleChildScrollView(
      child: Container(  
      
      margin: EdgeInsets.all(10),
      child: Column(
        
                children: <Widget>[
                  
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Image.network(data['strSportThumb']),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(data['strSport']),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(data['strSportDescription']),
                  ),
                ]
      ), 
    ), 
    ),
  );
  
}