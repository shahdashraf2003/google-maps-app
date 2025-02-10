import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latlng;
  PlaceModel({required this.id, required this.name, required this.latlng});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'صيدلية علام',
    latlng: LatLng(30.86317129083947, 32.309780567860194),
  ),
  PlaceModel(
    id: 2,
    name: 'كوبري السلام',
    latlng: LatLng(30.828696694093747, 32.317496371599184),
  ),
  PlaceModel(
    id: 3,
    name: 'كنيسة ماري جرجس',
    latlng: LatLng(30.867892798813177, 32.325654874552164),
  ),
];
