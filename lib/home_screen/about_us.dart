import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;

class AboutUs extends StatefulWidget {
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GoogleMapScreen()));
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

class GoogleMapScreen extends StatefulWidget {
  @override
  GoogleMapScreenState createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;
  
  
  void refresh() async {
    final center = await getUserLocation();
    mapController.addMarker(
      MarkerOptions(),);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 8.0)));
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                refresh();
                mapController.addMarker(
                  MarkerOptions(
                    position: LatLng(49.980719, 36.261454),
                    infoWindowText: InfoWindowText('Our Office', ''),
                  ),
                );
              },
              options: GoogleMapOptions(
                mapType: MapType.normal,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                cameraPosition: CameraPosition(
                  target: LatLng(49.98081, 36.25272),
                  zoom: 25.1,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
