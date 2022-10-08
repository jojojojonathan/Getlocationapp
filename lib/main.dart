import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var locationMessage = '';
  String latitude = '';
  String longtitude = '';

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    latitude = "$lat";
    longtitude = "$long";

    setState(() {
      locationMessage = "latitude: $lat and logtitude: $long";
    });
  }

  void googleMap() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longtitude";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Location App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 45.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Get User Location",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              locationMessage,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 05.0,
            ),
            FlatButton(
              color: Colors.white,
              onPressed: () {
                getCurrentLocation();
              },
              child: Text("Get User Location"),
            ),
            //Spacer(),
            SizedBox(
              height: 5.0,
            ),
            FlatButton(
              color: Colors.white,
              onPressed: () {
                googleMap();
              },
              child: Text("Open Google Maps"),
            ),
          ],
        )),
      ),
    );
  }
}
