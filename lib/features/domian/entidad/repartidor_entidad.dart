  import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


  class Pedido {
  final int idPedido;
  final String fechaPedido;
  final String estado;
  final int idRepartidor;
  final List<dynamic> DatosDelPedido;
  final String metodoPago;
  final int Resumen;

  Pedido({
    required this.idPedido,
    required this.fechaPedido,
    required this.estado,
    required this.idRepartidor,
    required this.DatosDelPedido,
    required this.metodoPago,
    required this.Resumen,
  });
}
  void cargarDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      setState(() {
        userData = jsonDecode(userDataString);
      });
    } else {
      // Si userDataString es nulo, inicializa userData como un Map vacío
      setState(() {
        userData = {};
      });
    }
  }

  Future<void> getPedido() async {
    try {
      var response = await http.get(Uri.parse(
          'http://44.210.116.192/pedidos/verDetallePedido/${widget.idPedido}'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          detallePedido = jsonResponse[
              'data']; // Actualiza la variable de estado con la información de response
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        // Si userDataString es nulo, inicializa userData como un Map vacío
        setState(() {
          detallePedido = {};
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }