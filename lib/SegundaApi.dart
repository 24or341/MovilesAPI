import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/my_painter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _MainAppState(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _MainAppState extends StatefulWidget {
  const _MainAppState({Key? key}) : super(key: key);

  @override
  _MainAppStateState createState() => _MainAppStateState();
}

class _MainAppStateState extends State<_MainAppState> {

final _initialCameraPosition = CameraPosition(
  target: LatLng(-18.0039888,-70.228054),
  zoom: 14,
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0099aa),
      appBar: AppBar(
        title: const Text('Main App'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}