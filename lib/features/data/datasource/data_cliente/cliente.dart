  import 'package:shared_preferences/shared_preferences.dart';

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
