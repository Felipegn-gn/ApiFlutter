import 'package:postgres/postgres.dart';
import '../../domain/entities/adicional.dart';
import '../../domain/interfaces/i_adicional_repository.dart';

class AdicionalRepository implements IAdicionalRepository {
  final Connection _connection;

  AdicionalRepository(this._connection);

  @override
  Future<List<Adicional>> getActiveAsync() async {
    // Equivalente ao .Where(a => a.Ativo).OrderBy(a => a.Nome)
    final result = await _connection.execute(
      'SELECT id, nome, preco, ativo FROM Adicionais '
      'WHERE ativo = TRUE '
      'ORDER BY nome ASC'
    );

    return result.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<Map<String, Adicional>> getByIdsAsync(Iterable<String> ids) async {
    // Equivalente ao .Distinct().ToList()
    final distinctIds = ids.toSet().toList();

    if (distinctIds.isEmpty) return {};

    // Equivalente ao .Where(a => distinctIds.Contains(a.Id) && a.Ativo)
    final result = await _connection.execute(
      Sql.named(
        'SELECT id, nome, preco, ativo FROM Adicionais '
        'WHERE id = ANY(@ids) AND ativo = TRUE'
      ),
      parameters: {'ids': distinctIds},
    );

    // Equivalente ao .ToDictionaryAsync(a => a.Id)
    final Map<String, Adicional> dictionary = {};
    for (var row in result) {
      final entity = _mapToEntity(row);
      dictionary[entity.id] = entity;
    }

    return dictionary;
  }

  /// Helper para evitar repetição de código no mapeamento
  Adicional _mapToEntity(ResultRow row) {
    return Adicional(
      id: row[0] as String,
      nome: row[1] as String,
      preco: (row[2] as double),
      ativo: row[3] as bool,
    );
  }
}