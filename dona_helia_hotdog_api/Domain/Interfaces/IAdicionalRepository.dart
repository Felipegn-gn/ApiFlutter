import '../entities/adicional.dart';

/// Interface de contrato para o repositório de Adicionais
abstract class IAdicionalRepository {
  /// Busca todos os adicionais que estão marcados como ativos
  Future<List<Adicional>> getActiveAsync();

  /// Busca uma lista de adicionais pelos seus IDs e retorna um Map (Dicionário)
  /// onde a chave é o ID (String) e o valor é a entidade Adicional.
  Future<Map<String, Adicional>> getByIdsAsync(Iterable<String> ids);
}