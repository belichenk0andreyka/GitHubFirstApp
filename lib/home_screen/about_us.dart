import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutUs extends StatefulWidget {
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  GoogleMapController myController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'We and YouTube',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              launchYouTube();
            },
          ),
          ListTile(
            title: Text(
              'We on map',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              GoogleMap();
            },
          ),      
        ],
      ),
    );
  }

  launchYouTube() async {
    String url = 'https://www.youtube.com/watch?v=upIhtRmjYiQ';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class GoogleMap extends StatefulWidget {
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoogleMaps'),
      ),
      body: GoogleMap(
         onMapCreated: (GoogleMapController controller) {
   mapController = controller;
 },
         options: GoogleMapOptions(
           trackCameraPosition: true,
           cameraPosition: CameraPosition(
             target: LatLng(49.988358, 36.232845),
             zoom: 11.0,
           ),
         ),
       ),
    );
  }
}

