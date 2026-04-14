import '../entities/endereco.dart';

/// Interface de contrato para o repositório de Endereços.
abstract class IEnderecoRepository {
  /// Busca um endereço específico garantindo que ele pertença ao cliente informado.
  /// Equivalente ao Task<Endereco?> do C#.
  Future<Endereco?> getByIdAndClienteIdAsync(String enderecoId, String clienteId);

  /// Salva um novo endereço no banco de dados.
  Future<Endereco> addAsync(Endereco endereco);
}