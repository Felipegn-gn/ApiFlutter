import 'package:postgres/postgres.dart';
import '../../domain/entities/produto.dart';
import '../../domain/entities/produto_ingrediente.dart';
import '../../domain/entities/ingrediente.dart';
import '../../domain/interfaces/i_produto_repository.dart';

class ProdutoRepository implements IProdutoRepository {
  final Connection _connection;

  ProdutoRepository(this._connection);

  @override
  Future<List<Produto>> getActiveAsync() async {
    // Equivalente ao .Where(p => p.Ativo).OrderBy(p => p.Nome)
    final result = await _connection.execute(
      'SELECT id, nome, descricao, preco_base, imagem_url, ativo '
      'FROM produtos WHERE ativo = TRUE ORDER BY nome ASC',
    );

    return result.map((row) => _mapToEntity(row)).toList();
  }

  @override
  Future<Produto?> getByIdWithIngredientesAsync(String id) async {
    // Equivalente ao .Include(p => p.ProdutoIngredientes).ThenInclude(pi => pi.Ingrediente)
    final result = await _connection.execute(
      Sql.named(
        'SELECT p.id, p.nome, p.descricao, p.preco_base, p.imagem_url, p.ativo, '
        'pi.id as pi_id, i.id as i_id, i.nome as i_nome '
        'FROM produtos p '
        'LEFT JOIN produto_ingredientes pi ON p.id = pi.produto_id '
        'LEFT JOIN ingredientes i ON pi.ingrediente_id = i.id '
        'WHERE p.id = @id AND p.ativo = TRUE',
      ),
      parameters: {'id': id},
    );

    if (result.isEmpty) return null;

    final firstRow = result.first;
    
    // Mapeamos a lista de ingredientes se eles existirem
    // Isso simula o comportamento do ThenInclude do C#
    final ingredientes = result
        .where((row) => row[6] != null) 
        .map((row) => ProdutoIngrediente(
              id: row[6] as String,
              produtoId: id,
              ingredienteId: row[7] as String,
              // ingrediente: Ingrediente(id: row[7] as String, nome: row[8] as String),
            ))
        .toList();

    return Produto(
      id: firstRow[0] as String,
      nome: firstRow[1] as String,
      descricao: firstRow[2] as String,
      precoBase: (firstRow[3] as double),
      imagemUrl: firstRow[4] as String,
      ativo: firstRow[5] as bool,
      // produtoIngredientes: ingredientes,
    );
  }

  @override
  Future<Map<String, Produto>> getByIdsAsync(Iterable<String> ids) async {
    final distinctIds = ids.toSet().toList();
    if (distinct