import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moviles_api_parte4/map_market.dart'; // Import corregido

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibGVhbmRyb2RobyIsImEiOiJjbTN0MXdod3cwMmZtMmpwdzhmMWNkcHgxIn0.atpzDvlfB_SQO692AHYooA';
const MAPBOX_STYLE = 'mapbox/dark-v10';
const MARKER_COLOR = Color(0xFF3DC5A7);
const MARKER_SIZE_EXPANDED = 55.0;
const MARKER_SIZE_SHRINKED = 38.0;

final LatLng myLocation = LatLng(-12.0362176, -77.0296812); // Variable corregida

class AnimatedMarkersMap extends StatefulWidget {
  const AnimatedMarkersMap({Key? key}) : super(key: key);

  @override
  State<AnimatedMarkersMap> createState() => _AnimatedMarkersMapState();
}

class _AnimatedMarkersMapState extends State<AnimatedMarkersMap> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];
      _markerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = i; // Cambiar aquí para que el índice se actualice correctamente
                  _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut);
                });
                print('Selected: ${mapItem.title}');
              },
              child: _LocationMarker(
                selected: _selectedIndex == i,
              ),
            );
          },
        ),
      );
    }
    return _markerList;
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Markers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () => null, // Acción temporal
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: myLocation, // Variable corregida
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': MAPBOX_STYLE,
                },
              ),
              MarkerLayer(
                markers: _markers,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: myLocation, // Variable corregida
                    width: 50, // Especificar ancho y alto según la versión.
                    height: 50,
                    builder: (_) => const _MyLocationMarker(),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                final item = mapMarkers[index];
                return _MapItemDetails(
                  mapMarker: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationMarker extends StatelessWidget {
  const _LocationMarker({Key? key, this.selected = false}) : super(key: key);

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final size = selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.asset('assets/marker.png'), // Asegúrate de tener esta imagen
      ),
    );
  }
}

class _MyLocationMarker extends StatelessWidget {
  const _MyLocationMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: MARKER_COLOR,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({
    Key? key,
    required this.mapMarker,
  }) : super(key: key);

  final MapMarker mapMarker;

  @override
  Widget build(BuildContext context) {
    final _styleTittle = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 14);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(mapMarker.image),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          mapMarker.title,
                          style: _styleTittle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          mapMarker.address,
                          style: _styleAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => null, // Acción temporal
              color: MARKER_COLOR,
              elevation: 6,
              child: Text(
                'CALL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}