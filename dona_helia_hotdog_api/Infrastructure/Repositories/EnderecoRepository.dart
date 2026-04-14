import 'package:postgres/postgres.dart';
import '../../domain/entities/endereco.dart';
import '../../domain/interfaces/i_endereco_repository.dart';

class EnderecoRepository implements IEnderecoRepository {
  final Connection _connection;

  EnderecoRepository(this._connection);

  @override
  Future<Endereco?> getByIdAndClienteIdAsync(String enderecoId, String clienteId) async {
    // Equivalente ao FirstOrDefaultAsync com o filtro de segurança de ClienteId
    final result = await _connection.execute(
      Sql.named(
        'SELECT id, cliente_id, logradouro, numero, bairro '
        'FROM enderecos '
        'WHERE id = @eId AND cliente_id = @cId'
      ),
      parameters: {
        'eId': enderecoId,
        'cId': clienteId,
      },
    );

    if (result.isEmpty) return null;

    final row = result.first;
    return Endereco(
      id: row[0] as String,
      clienteId: row[1] as String,
      logradouro: row[2] as String,
      numero: row[3] as String,
      bairro: row[4] as String,
    );
  }

  @override
  Future<Endereco> addAsync(Endereco endereco) async {
    // Equivalente ao _context.Enderecos.Add e SaveChangesAsync
    await _connection.execute(
      Sql.named(
        'INSERT INTO enderecos (id, cliente_id, logradouro, numero, bairro) '
        'VALUES (@id, @cId, @log, @num, @bai)'
      ),
      parameters: {
        'id': endereco.id,
        'cId': endereco.clienteId,
        'log': endereco.logradouro,
        'num': endereco.numero,
        'bai': endereco.bairro,
      },
    );

    return endereco;
  }
}