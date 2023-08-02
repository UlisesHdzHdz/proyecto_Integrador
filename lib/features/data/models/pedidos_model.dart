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