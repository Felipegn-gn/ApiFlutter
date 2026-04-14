// Importações das entidades relacionadas
// import 'produto.dart';
// import 'ingrediente.dart';

class ProdutoIngrediente {
  final String id;
  final String produtoId;
  final String ingredienteId;

  // Propriedades de Navegação
  // Permitem acessar os detalhes do Produto ou do Ingrediente 
  // a partir desta relação de "receita".
  
  // final Produto? produto;
  // final Ingrediente? ingrediente;

  ProdutoIngrediente({
    required this.id,
    required this.produtoId,
    required this.ingredienteId,
    // this.produto,
    // this.ingrediente,
  });
}