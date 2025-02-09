import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: LatLng(30.863139458194, 32.31127632883563),
      zoom: 13,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          southwest: const LatLng(30.810456602245626, 32.28496915086855),
          northeast: const LatLng(30.878020284717195, 32.33217750066308),
        ),
      ),
      initialCameraPosition: initialCameraPosition,
    );
  }
}

//world view 0->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20
