 import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> getPedido() async {
    try {
      var response = await http
          .get(Uri.parse('http://44.210.116.192/pedidos/getAllPedidos'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
    
      } else {
        print('Request failed with status: ${response.statusCode}.');
     
      }
    } catch (e) {
      print('Error: $e');
    }
  }

   Future<void> getRepartidores() async {
    try {
      var response = await http.get(
          Uri.parse('http://44.210.116.192/repartidores/obtenerRepartidores'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  
  Future<Map<String, dynamic>> getClientData(idCliente) async {
    try {
      var response = await http.get(Uri.parse(
          'http://44.210.116.192/clientes/verDetallesCliente/${idCliente}'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
        return jsonResponse['data'];
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }