import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController controller;
  String? mapStyle;
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: LatLng(30.863139458194, 32.31127632883563),
      zoom: 13.5,
    );
    initMapStyle();
    initMarkers();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          //mapType: MapType.satellite,
          style: mapStyle,
          onMapCreated: (GoogleMapController mapController) {
            controller = mapController;
          },

          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: const LatLng(30.810456602245626, 32.28496915086855),
          //     northeast: const LatLng(30.878020284717195, 32.33217750066308),
          //   ),
          // ),
          initialCameraPosition: initialCameraPosition,
          markers: markers,
        ),
        Positioned(
          bottom: 10,
          right: 70,
          left: 70,
          child: FloatingActionButton(
            onPressed: () {
              controller.animateCamera(
                //new camera position || target|| zoom||latlag
                CameraUpdate.newLatLngZoom(
                  LatLng(31.265233651608934, 32.3009611960651),
                  12,
                ),
              );
            },
            child: const Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }

  Future<void> initMapStyle() async {
    mapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');
    setState(() {});
  }

  void initMarkers() {
    Marker myMarker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.863139458194, 32.31127632883563),
    );
    markers.add(myMarker);
  }
}

//world view 0->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20
