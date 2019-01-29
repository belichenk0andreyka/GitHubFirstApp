import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logining/home_screen/inform_team.dart';

class TeamGorList extends StatefulWidget {
  final String _idLeague;
  final String _leagueName;

  TeamGorList(this._idLeague, this._leagueName);

  @override
  _TeamGorListState createState() => _TeamGorListState(_idLeague, _leagueName);
}

class _TeamGorListState extends State<TeamGorList> {
  final String _idLeague;
  final String _leagueName;

  _TeamGorListState(this._idLeague, this._leagueName);

  List data;

  Future<List> getJsonData() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=$_idLeague'),
        headers: {"Accept": "application/json"});

    var jsonData = json.decode(response.body);
    data = jsonData['teams'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_leagueName),
        ),
        body: FutureBuilder(
            future: getJsonData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: PageController(viewportFraction: 1.5),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 120, vertical: 60),
                            child: Stack(children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                  width: 300.0,
                                  height: 400.0,
                                  alignment: AlignmentDirectional.center,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(data[index]["strTeam"].toString(),
                                            style: TextStyle(
                                                fontSize: 35,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal),
                                            textAlign: TextAlign.center),
                                        SizedBox(height: 50),
                                        Hero(
                                          tag:
                                              'imageHero${data[index]["strTeam"]}',
                                          child: Image.network(
                                            data[index]["strTeamBadge"],
                                            width: 230,
                                          ),
                                        ),
                                      ])),
                              GestureDetector(onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return TeamInform(
                                      data[index]['strTeam'],
                                      data[index]['strTeamBadge'],
                                      data[index]['strDescriptionEN'],
                                      data[index]['strWebsite'],
                                      data[index]['strInstagram'],
                                      data[index]['strYoutube'],
                                      data[index]['strFacebook'],
                                      data[index]['strTwitter']);
                                }));
                              }),
                            ]));
                      })
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 180, horizontal: 150),
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}
