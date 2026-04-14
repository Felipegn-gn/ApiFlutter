import '../entities/produto.dart';

/// Interface de contrato para o repositório de Produtos.
abstract class IProdutoRepository {
  /// Retorna uma lista de todos os produtos que estão marcados como ativos.
  Future<List<Produto>> getActiveAsync();

  /// Busca um produto específico carregando sua "receita" (Ingredientes).
  /// Equivalente ao Include() do Entity Framework ou JOIN no SQL.
  Future<Produto?> getByIdWithIngredientesAsync(String id);

  /// Recebe uma lista de IDs e retorna um Map (Dicionário) para acesso rápido.
  /// Chave: ID do produto | Valor: Entidade Produto completa.
  Future<Map<String, Produto>> getByIdsAsync(Iterable<String> ids);
}