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

Future<void> _loadPedidosList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedPedidos = prefs.getStringList('pedidos');
    if (savedPedidos != null) {
   
    }
  }

  Future<void> _savePedidosList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'pedidos', listaPedidos.map((pedido) => pedido.toString()).toList());
  }

    saveInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('totalAPagar', total);
    print(total);
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