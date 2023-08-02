    import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

  
  
  Future<void> registrarRepartidor() async {
    final url =
        Uri.parse('http://44.210.116.192/repartidores/registrarRepartidor');
    final cliente = {
      'nombre': nombre.text,
      'direccion': direccion.text,
      'telefono': numeroTelefono.text,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(cliente),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200 && responseData['status'] == true) {
        // El cliente se registró exitosamente
        print('Repartidor creado exitosamente.');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeAdm()),
        );
        // Aquí puedes agregar lógica para mostrar una confirmación al usuario o realizar otra acción.
      } else {
        // Hubo un error al registrar el cliente
        print('Error al registrar el cliente: ${responseData['message']}');
        // Aquí puedes agregar lógica para mostrar un mensaje de error al usuario.
      }
    } catch (e) {
      print('Error: $e');
      // Aquí puedes agregar lógica para mostrar un mensaje de error al usuario.
    }
  }