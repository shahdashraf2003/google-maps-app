import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/place_model.dart';

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
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: LatLng(30.863139458194, 32.31127632883563),
      //zoom: 13,
      zoom:1,
    );
    initMapStyle();
    initMarkers();
    initPolylines();
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
          zoomControlsEnabled: false,
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
          polylines: polylines,
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

  void initMarkers() async {
    var customMarkerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      'assets/images/green-location-icons-17.png',
    );
    var myMarkers =
        places
            .map(
              (placeModel) => Marker(
                icon: customMarkerIcon,
                infoWindow: InfoWindow(title: placeModel.name),
                markerId: MarkerId(placeModel.id.toString()),
                position: placeModel.latlng,
              ),
            )
            .toSet();
    markers.addAll(myMarkers);

    // Marker myMarker = Marker(
    //   markerId: MarkerId('1'),
    //   position: LatLng(30.863139458194, 32.31127632883563),
    // );
    // markers.add(myMarker);
  }

  void initPolylines() {
    Polyline polyline1 = Polyline(
      polylineId: PolylineId('1'),
      zIndex: 2, //if it take bigger value it will be above the other polyline
      color: Colors.red,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      width: 5,
      points: [
        places[0].latlng,
        places[1].latlng,
        places[2].latlng,
        LatLng(30.876469813096787, 32.33976147913657),
        LatLng(30.8763419139233, 32.36598879515685),
        LatLng(30.919470773085674, 32.313638927785355),
      ],
    );
    Polyline polyline2 = Polyline(
      polylineId: PolylineId('2'),
      zIndex: 1,
      //patterns: [PatternItem.dot], not real lines
      color: Colors.greenAccent,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      width: 5,
      points: [
        LatLng(30.850600331654498, 32.29056526338708),
        LatLng(30.853768675021822, 32.343266834642506),
      ],
    );
     Polyline polylineWorld = Polyline(
      geodesic: true,//to make the line in curve because the earth is not flat
      polylineId: PolylineId('3'),
      zIndex: 3,
      color: Colors.lightBlueAccent,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      width: 5,
      points: [
        LatLng(83.97272072531403, 40.75121293223401),
        LatLng(-31.655255283706108, 23.700432033754932),
      ],
    );
    polylines.add(polyline1);
    polylines.add(polyline2);
    polylines.add(polylineWorld);
  }
}

//world view 0->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20
