import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logining/account_screen/countriesList.dart';
import 'package:logining/home_screen/team_gorList.dart';

class LeaguesAviable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeaguesAviableState();
}

class LeaguesAviableState extends State<LeaguesAviable> {
  String _choisesport;
  String _choiseCountry;

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            SizedBox(width: 10),
            FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot) {
              return DropdownButton(
                value: _choiseCountry,
                hint: Text('Choise country'),
                items: _dropDownMenuItems,
                onChanged: (String newValue) {
                  setState(() {
                    _choiseCountry = newValue;
                  });
                },
              );
            }),
            SizedBox(width: 10),
            FutureBuilder(
                future: _sports(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? DropdownButton(
                          value: _choisesport,
                          hint: Text("Select sport"),
                          items: snapshot.data,
                          onChanged: (value) {
                            _choisesport = value;
                            setState(() {});
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: CircularProgressIndicator(),
                        );
                })
          ]),
          Flexible(
              child: FutureBuilder(
                  future: _getListLeagues(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index];
                            })
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 180, horizontal: 150),
                            child: CircularProgressIndicator(),
                          );
                  }))
        ]),
      ),
    );
  }

  Future<List<ListTile>> _getListLeagues() async {
    http.Response data;
    String _str = "countrys";
    List<ListTile> listTiles = [];

    if ((_choiseCountry == null) & (_choisesport == null)) {
      data = await http
          .get("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php");
      _str = "leagues";
    } else if ((_choisesport != null) & (_choiseCountry == null)) {
      data = await http.get(
          "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=$_choisesport");
    } else if ((_choiseCountry != null) & (_choisesport == null)) {
      data = await http.get(
          "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=$_choiseCountry");
    } else {
      data = await http.get(
          "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=$_choiseCountry&s=$_choisesport");
    }

    var jsonData = json.decode(data.body);

    for (var index in jsonData[_str]) {
      if (((_choisesport != null) & (_choisesport == index["strSport"])) |
          (_choisesport == null)) {
        ListTile list = ListTile(
          title: Text(index["strLeague"]),
          subtitle: Text(index["strSport"]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TeamGorList(index['idLeague'], index['strLeague']),
                ));
          },
        );
        listTiles.add(list);
      }
    }
    return listTiles;
  }
}

Future<List<DropdownMenuItem<String>>> _sports() async {
  var data = await http
      .get("https://www.thesportsdb.com/api/v1/json/1/all_sports.php");
  var jsonData = json.decode(data.body);

  List<DropdownMenuItem<String>> droplist = [];

  for (var sport in jsonData["sports"]) {
    droplist.add(DropdownMenuItem(
      child: Row(children: <Widget>[
        Text(sport["strSport"].toString()),
      ]),
      value: sport["strSport"],
    ));
  }
  return droplist;
}
