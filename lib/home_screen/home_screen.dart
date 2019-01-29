import 'package:flutter/material.dart';
import 'package:logining/home_screen/list_sports.dart';
import 'package:logining/home_screen/leagues_list.dart';
import 'package:logining/home_screen/about_us.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ListSports(),
    LeaguesAviable(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flutter'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_box),
          tooltip: 'Transition to avatar screen',
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/avatar', (Route<dynamic> route) => false);
          },
        ),
        IconButton(
            icon: Icon(Icons.share),
            tooltip: 'Action Tool Tip',
            onPressed: () {
              print("onPressed");
            }),
        IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Action Tool Tip',
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }),
      ]),
      resizeToAvoidBottomPadding: false,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
           UserAccountsDrawerHeader(
             accountName: Text('Andrey'),
             accountEmail: Text('myletter@example.com'),
            currentAccountPicture: Image(
              image: AssetImage('images/logo.png'),
              width: 70,
              alignment: Alignment.topRight,
            ),
           ),
            ListTile(
              title: Text('About us'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        fixedColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('List Sports')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Aviable Ligues')),
        ],
      ),
    );
  }
}
//
