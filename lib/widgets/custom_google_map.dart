import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_app/models/place_model.dart';
import 'package:maps_app/utils/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? controller;
  String? mapStyle;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  late LocationService locationService;

  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: LatLng(30.863139458194, 32.31127632883563),
      //zoom: 13,
      zoom: 5,
    );
    initMapStyle();
    initMarkers();
    initPolylines();
    initPolygons();
    initCircles();
    locationService = LocationService();
    setMylocation();
  }

  @override
  void dispose() {
    controller?.dispose();
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
          polylines: polylines, //just for lines
          polygons: polygons, // shapes (lines with filled color)
          circles: circles,
        ),
        Positioned(
          bottom: 10,
          right: 70,
          left: 70,
          child: FloatingActionButton(
            onPressed: () {
              controller?.animateCamera(
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
      geodesic: true, //to make the line in curve because the earth is not flat
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

  void initPolygons() {
    Polygon egyptPolygon = Polygon(
      polygonId: PolygonId('1'),
      fillColor: Colors.black45,
      strokeColor: Colors.black45,
      strokeWidth: 2,
      holes: [
        [
          LatLng(27.087673673991652, 28.497280313604296),
          LatLng(26.964264977589732, 29.567082549378082),
          LatLng(26.12299108827917, 29.403533035699766),
          LatLng(25.94664670870367, 28.19326663448024),
        ],
      ], //to make a hole in the polygon and should be inside the polygon
      points: [
        LatLng(22.124711633301946, 24.974973620817988),
        LatLng(29.28485171310749, 25.01891893159485),
        LatLng(30.20058054687552, 24.66735644537998),
        LatLng(30.23855381977006, 24.711301756156832),
        LatLng(30.73086791593862, 24.974973620817988),
        LatLng(31.333355820565775, 24.843137688487413),
        LatLng(31.707967203153746, 25.10680955314856),
        LatLng(31.808437748951427, 25.348814361444347),
        LatLng(30.759141501615186, 29.05641869133003),
        LatLng(31.048344686273772, 29.706453216699593),
        LatLng(31.583108380876226, 31.006522267438726),
        LatLng(31.4394324784571, 31.825084262348554),
        LatLng(31.089588015147836, 32.64364625725838),
        LatLng(30.02535362645364, 32.55486443683632),
        LatLng(22.165415205484816, 36.708371598239175),
      ],
    );
    polygons.add(egyptPolygon);
  }

  void initCircles() {
    Circle circle = Circle(
      circleId: CircleId('1'),
      center: LatLng(30.863139458194, 32.31127632883563),
      radius: 10000,
      fillColor: const Color.fromARGB(255, 213, 180, 228),
      strokeColor: const Color.fromARGB(255, 213, 180, 228),
      strokeWidth: 2,
    );
    circles.add(circle);
  }

  void setMylocation() async {
    await locationService.checkAndRequestLocationService();
    bool hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData(2, (locationData) {
        setMyCameraPosition(locationData);

        setMyLocationMarker(locationData);
      });
    } else {}
  }

  void setMyLocationMarker(LocationData locationData) {
    Marker myLocationMarker = Marker(
      markerId: MarkerId('my_location_marker'),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );
    setState(() {});
    markers.add(myLocationMarker);
  }

  void setMyCameraPosition(LocationData locationData) {
    var cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 15,
    );
    controller?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}

//zoom level
//world view 0->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20
//******************************************************//
//location tracking
//inquire about location service
//request permission
//get the current location
//display the current location
