import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.greenAccent.shade700),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(38.423733, 27.142826),
    zoom: 14.4746,
  );

  // static final CameraPosition _konum = CameraPosition(
  //   target: LatLng(23.22, 27.142826),
  //   zoom: 14.4746,
  // );

  static final CameraPosition _iskele = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(38.439, 27.1408),
      tilt: 59.440717697143555,
      zoom: 20.151926040649414);

  Set<Marker> _markers = {};

  // kendi konumuma gitmek için diğer yol

  // Position? currentPosition;
  //var geolocator = Geolocator();

  // getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   currentPosition = position;
  //   LatLng latLng = LatLng(position.latitude, position.longitude);
  //   GoogleMapController controller = await _controller.future;
  //   CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 15);
  //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //   setState(() {
  //     _markers.add(Marker(markerId: MarkerId("Konumum"), position: latLng));
  //   });
  //   //await Geolocator.openAppSettings();
  //   //await Geolocator.openLocationSettings();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Google Maps API",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onLongPress: (argument) {
          setState(() {
            _markers.add(Marker(
                markerId: MarkerId("Konum"),
                position: argument,
                infoWindow: InfoWindow(title: "Konum Seçildi!")));
          });
        },
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          // setState(() {
          //   _markers.add(Marker(
          //     markerId: MarkerId("Açılış"),
          //     position: LatLng(38.439, 27.1408),
          //   ));
          // });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.greenAccent.shade700,
        onPressed: _iskeleyeGit,
        label: Text('Alsancak İskele'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _iskeleyeGit() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_iskele));
  }
}
