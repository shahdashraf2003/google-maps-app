import 'package:flutter/material.dart';
import 'package:maps_app/widgets/custom_google_map.dart';

void main() {
  runApp(const TestGoogleMaps());
}

class TestGoogleMaps extends StatelessWidget {
  const TestGoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CustomGoogleMap(),
    );
  }
}
