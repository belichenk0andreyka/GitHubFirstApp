import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamInform extends StatelessWidget {
  final String teamName;
  final String picture;
  final String teamDescription;
  final String website;
  final String instagtam;
  final String youtube;
  final String facebook;
  final String twitter;

  TeamInform(
    this.teamName,
    this.picture,
    this.teamDescription,
    this.website,
    this.instagtam,
    this.youtube,
    this.facebook,
    this.twitter,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(teamName),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Hero(
              tag: 'imageHero$teamName',
              child: Image.network(picture, width: 150)),
          Text(
            teamName,
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Text(
              teamDescription,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getLinkSite(),
                getLinkInstagram(),
                getLinkFacebook(),
                getLinkTwitter()
              ])
        ])));
  }

  Widget getLinkSite() {
    if (website.length != 0) {
      return Row(children: <Widget>[
        Image.network(
            "https://pngimage.net/wp-content/uploads/2018/06/site-png-1.png",
            width: 30),
        FlatButton(
            onPressed: () {
              loadWebSite(website);
            },
            child: Text(website, style: TextStyle(fontSize: 15)))
      ]);
    } else {
      return SizedBox(height: 0);
    }
  }

  Widget getLinkInstagram() {
    if (instagtam.length != 0) {
      return Row(children: <Widget>[
        Image.network(
            "http://pluspng.com/img-png/instagram-png-instagram-png-logo-1455.png",
            width: 30),
        FlatButton(
            onPressed: () {
              loadWebSite(instagtam);
            },
            child: Text(instagtam, style: TextStyle(fontSize: 15)))
      ]);
    } else {
      return SizedBox(height: 0);
    }
  }

  Widget getLinkFacebook() {
    if (facebook.length != 0) {
      return Row(children: <Widget>[
        Image.network(
            "http://www.iconarchive.com/download/i54037/danleech/simple/facebook.ico",
            width: 30),
        FlatButton(
            onPressed: () {
              loadWebSite(facebook);
            },
            child: Text(facebook, style: TextStyle(fontSize: 15)))
      ]);
    } else {
      return SizedBox(height: 0);
    }
  }

  Widget getLinkTwitter() {
    if (twitter.length != 0) {
      return Row(children: <Widget>[
        Image.network("http://pngimg.com/uploads/twitter/twitter_PNG39.png",
            width: 30),
        FlatButton(
            onPressed: () {
              loadWebSite(twitter);
            },
            child: Text(twitter, style: TextStyle(fontSize: 15)))
      ]);
    } else {
      return SizedBox(height: 0);
    }
  }

  void loadWebSite(String url) async {
    if (await canLaunch("http://$url")) {
      await launch("http://$url");
    } else {
      throw 'Could not launch $url';
    }
  }
}
