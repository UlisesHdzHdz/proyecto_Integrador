  import 'package:shared_preferences/shared_preferences.dart';
  





  class Cliente {
  final String nombre;
  final String correoElectronico;
  final String contrasenia;
  final String direccion;
  final String telefono;

  Cliente({
    required this.nombre,
    required this.correoElectronico,
    required this.contrasenia,
    required this.direccion,
    required this.telefono,
  });
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