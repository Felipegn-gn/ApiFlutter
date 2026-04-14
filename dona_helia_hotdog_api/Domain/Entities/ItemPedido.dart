// Importações hipotéticas das entidades de relacionamento
// import 'pedido.dart';
// import 'produto.dart';
// import 'item_pedido_remocao.dart';
// import 'item_pedido_adicional.dart';

class ItemPedido {
  final String id;
  final String pedidoId;
  final String produtoId;
  final int quantidade;
  final double precoUnitarioCalculado; // decimal no C# vira double no Dart
  final String observacaoItem;

  // Propriedades de Navegação
  // Assim como no Entity Framework, você pode ter instâncias das classes aqui.
  // Em Dart, usamos '?' (Nullable) para relações 1:1 que podem não estar
  // carregadas na memória logo de cara (lazy loading / sem JOIN no repositório).
  // E usamos List para ICollection.
  
  // final Pedido? pedido;
  // final Produto? produto;
  // final List<ItemPedidoRemocao> remocoes;
  // final List<ItemPedidoAdicional> adicionais;

  ItemPedido({
    required this.id,
    required this.pedidoId,
    required this.produtoId,
    required this.quantidade,
    required this.precoUnitarioCalculado,
    this.observacaoItem = '', // Garante que não seja null se vier vazio
    
    // this.pedido,
    // this.produto,
    // this.remocoes = const [],
    // this.adicionais = const [],
  });
}