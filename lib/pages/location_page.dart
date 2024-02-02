import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String locationMessage = "Current Location";
  late String lat;
  late String long;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions have been denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });

    setState(() {
      locationMessage = "Latitude: $lat, Longitude: $long";
    });
  }

  Future<void> _openMap(String lat, String long) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    // await canLaunchUrlString(url) ? await launchUrlString(url) : throw "Could not launch $url";
    await launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              locationMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation().then((value) {
                  lat = "${value.latitude}";
                  long = "${value.longitude}";
                  setState(() {
                    locationMessage = "Latitude: $lat, Longitude: $long";
                  });
                  _liveLocation();
                });
              },
              child: const Text("Get Current Location"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openMap(lat, long);
              },
              child: const Text('Open Google Maps'),
            )
          ],
        ),
      ),
    );
  }
}
