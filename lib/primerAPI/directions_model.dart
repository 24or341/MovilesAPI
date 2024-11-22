import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final double totalDistance;
  final double totalDuration;

  Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Get route information
    final routesList = map['routes'] as List?;
    if (routesList == null || routesList.isEmpty) {
      // Return a default Directions object with empty/zero values
      return Directions(
        bounds: LatLngBounds(
          northeast: LatLng(0, 0),
          southwest: LatLng(0, 0),
        ),
        polylinePoints: [],
        totalDistance: 0.0,
        totalDuration: 0.0,
      );
    }

    final data = Map<String, dynamic>.from(routesList.first);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    // Distance & Duration
    double distance = 0.0;
    double duration = 0.0;
    final legsList = data['legs'] as List?;
    if (legsList != null && legsList.isNotEmpty) {
      final leg = legsList.first;
      distance = leg['distance']['value'].toDouble();
      duration = leg['duration']['value'].toDouble();
    }

    return Directions(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
