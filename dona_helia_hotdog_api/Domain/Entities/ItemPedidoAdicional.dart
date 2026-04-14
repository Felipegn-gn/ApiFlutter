// Importações das entidades relacionadas
// import 'item_pedido.dart';
// import 'adicional.dart';

class ItemPedidoAdicional {
  final String id;
  final String itemPedidoId;
  final String adicionalId;
  final int quantidade;
  final double precoUnitarioAdicional; // decimal no C# vira double no Dart

  // Propriedades de Navegação (Relacionamentos)
  // Assim como nas outras classes, deixamos como opcionais (?) para 
  // carregar os dados apenas quando necessário (Eager Loading).
  
  // final ItemPedido? itemPedido;
  // final Adicional? adicional;

  ItemPedidoAdicional({
    required this.id,
    required this.itemPedidoId,
    required this.adicionalId,
    required this.quantidade,
    required this.precoUnitarioAdicional,
    // this.itemPedido,
    // this.adicional,
  });
}