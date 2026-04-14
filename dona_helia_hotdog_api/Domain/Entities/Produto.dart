// Importações das entidades relacionadas
// import 'produto_ingrediente.dart';
// import 'item_pedido.dart';

class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double precoBase;
  final String imagemUrl;
  final bool ativo;

  // Propriedades de Navegação
  // Assim como no Pedido, usamos List para representar as ICollections do C#.
  // final List<ProdutoIngrediente> produtoIngredientes;
  // final List<ItemPedido> itensPedido;

  Produto({
    required this.id,
    required this.nome,
    this.descricao = '',
    required this.precoBase,
    this.imagemUrl = '',
    this.ativo = true,
    // this.produtoIngredientes = const [],
    // this.itensPedido = const [],
  });
}