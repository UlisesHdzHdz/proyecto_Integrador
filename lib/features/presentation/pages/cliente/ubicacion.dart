import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibGF1cm8xMS0iLCJhIjoiY2xra2xuMGcxMDR5ZDNlbXZyZ28yZGs5ayJ9.nM9mnxzL9QPDE_oqULfesQ';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  gmf.LatLng? myPosition;
  bool showAddButton = false;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = gmf.LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    Timer(Duration(seconds: 8), () {
      setState(() {
        showAddButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mapa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : FlutterMap(
              options: MapOptions(
                center: LatLng(myPosition!.latitude, myPosition!.longitude),
                minZoom: 5,
                maxZoom: 25,
                zoom: 18,
              ),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                  additionalOptions: const {
                    'accessToken': MAPBOX_ACCESS_TOKEN,
                    'id': 'mapbox/streets-v12'
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point:
                          LatLng(myPosition!.latitude, myPosition!.longitude),
                      builder: (context) {
                        return Container(
                          child: const Icon(
                            Icons.person_pin,
                            color: Colors.blueAccent,
                            size: 40,
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
      floatingActionButton: showAddButton
          ? FloatingActionButton(
              onPressed: () async {
                String? address = await getAddressFromCoordinates(myPosition!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocationScreen(
                      location: myPosition!,
                      address: address,
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  Future<String?> getAddressFromCoordinates(gmf.LatLng coordinates) async {
    try {
      final apiKey = "TU_CLAVE_DE_API_DE_GOOGLE_MAPS";
      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=$apiKey";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == "OK") {
          String formattedAddress = data["results"][0]["formatted_address"];
          return formattedAddress;
        } else {
          return 'Dirección no encontrada';
        }
      } else {
        return 'Error al obtener la dirección';
      }
    } catch (e) {
      print('Error getting address: $e');
      return 'Error al obtener la dirección';
    }
  }
}

class AddLocationScreen extends StatelessWidget {
  final gmf.LatLng location;
  final String? address;

  AddLocationScreen({required this.location, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Ubicación'),
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Dirección: ${address ?? "Cargando..."}'),
                Text('Latitud: ${location.latitude}'),
                Text('Longitud: ${location.longitude}'),
                // Agrega aquí cualquier otra información relevante sobre la ubicación
              ],
            ),
          ),
        ),
      ),
    );
  }
}
