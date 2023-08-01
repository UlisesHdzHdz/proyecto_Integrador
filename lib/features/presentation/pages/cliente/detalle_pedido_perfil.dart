import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DetallePedido extends StatefulWidget {
  final int idPedido;
  const DetallePedido({
    Key? key,
    required this.idPedido,
  }) : super(key: key);

  @override
  State<DetallePedido> createState() => _DetallePedidoState();
}

class _DetallePedidoState extends State<DetallePedido> {
  int myIndex = 0;
  int counter = 0;
  Map<String, dynamic>? detallePedido;
  Map<String, dynamic>? userData;
  List<int> listaPedidos = [];
  int pedidosRealizados = 0;
  String selectedOption = 'Tipo de Pago'; // Opción seleccionada inicialmente

  @override
  void initState() {
    super.initState();
    getPedido();
    cargarDatosUsuario();
  }

  void incrementCounter() {
    setState(() {
      counter++;
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

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle del Pedido',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 72, 115, 191),
      ),
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Text(
                'Pedido: #${widget.idPedido}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                detallePedido?.containsKey('fechaPedido') == true
                    ? detallePedido!['fechaPedido']!
                    : '2023-07-25',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: SizedBox(
                  width: 300.0,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Estado:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'En proceso',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: SizedBox(
                      width: 300,
                      height: 170,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Datos del pedido:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            userData?.containsKey('nombre') == true
                                ? userData!['nombre']!
                                : 'Usuario Desconocido',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            detallePedido?.containsKey('calle') == true
                                ? detallePedido!['calle']!
                                : 'Calle no definida',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            detallePedido?.containsKey('colonia') == true
                                ? detallePedido!['colonia']!
                                : 'Colonia Ilusión',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            detallePedido?.containsKey('numeroTelefono') == true
                                ? detallePedido!['numeroTelefono']!
                                : 'Numero no definido',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Metodo de pago:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            detallePedido?.containsKey('tipoPago') == true
                                ? detallePedido!['tipoPago']!
                                : 'Efectivo',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                      },
                      child: SizedBox(
                        width: 300,
                        height: 100,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'Resumen:',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '\$${detallePedido?.containsKey('total') == true ? detallePedido!['total']! : '0'}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
