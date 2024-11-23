import 'package:flutter/material.dart';
import 'map_animated_markers_map.dart'; // Asegúrate de que este archivo contiene tu widget principal

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Para ocultar la bandera de debug
      home: MainAnimatedMarkersMap(), // Cambia el widget a tu implementación
    );
  }
}
