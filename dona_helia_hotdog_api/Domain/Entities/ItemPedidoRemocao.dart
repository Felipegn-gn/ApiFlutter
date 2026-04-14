// Importações das entidades relacionadas
// import 'item_pedido.dart';
// import 'ingrediente.dart';

class ItemPedidoRemocao {
  final String id;
  final String itemPedidoId;
  final String ingredienteId;

  // Propriedades de Navegação (Relacionamentos)
  // Mantemos como opcionais (?) seguindo o padrão de Clean Architecture
  // para permitir que o Repositório carregue esses objetos apenas se necessário.
  
  // final ItemPedido? itemPedido;
  // final Ingrediente? ingrediente;

  ItemPedidoRemocao({
    required this.id,
    required this.itemPedidoId,
    required this.ingredienteId,
    // this.itemPedido,
    // this.ingrediente,
  });
}