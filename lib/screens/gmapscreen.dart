import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GmapScreen extends StatefulWidget {
  final double lat, lng;
  const GmapScreen({Key key, this.lat, this.lng}) : super(key: key);

  @override
  _GmapScreenState createState() => _GmapScreenState();
}

class _GmapScreenState extends State<GmapScreen> {
  Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('1'),
        position: LatLng(widget.lat, widget.lng),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fault Location"),
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.lng),
            zoom: 17,
          ),
        ));
  }
}
