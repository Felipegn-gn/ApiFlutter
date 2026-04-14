// Importações hipotéticas das entidades de relacionamento
// import 'produto_ingrediente.dart';
// import 'item_pedido_remocao.dart';

class Ingrediente {
  final String id;
  final String nome;

  // No C#, o Entity Framework usa ICollection para mapear relacionamentos (1:N ou N:N).
  // No Dart, o equivalente direto é o List. 
  // Na Clean Architecture pura, evitamos referências bidirecionais diretas nas entidades 
  // base para evitar dependências circulares, mas deixei preparado (comentado) 
  // caso a sua regra de negócio exija essa navegação a partir do Ingrediente.
  
  // final List<ProdutoIngrediente> produtoIngredientes;
  // final List<ItemPedidoRemocao> itemPedidoRemocoes;

  Ingrediente({
    required this.id,
    required this.nome,
    // this.produtoIngredientes = const [],
    // this.itemPedidoRemocoes = const [],
  });
}