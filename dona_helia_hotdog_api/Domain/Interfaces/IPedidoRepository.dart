import '../entities/pedido.dart';

/// Interface de contrato para o repositório de Pedidos.
abstract class IPedidoRepository {
  /// Salva um novo pedido e retorna a instância persistida.
  Future<Pedido> addAsync(Pedido pedido);

  /// Busca um pedido pelo ID trazendo todos os seus relacionamentos 
  /// (Eager Loading de Itens, Adicionais, Remoções, etc).
  /// Equivalente ao Task<Pedido?> do C#.
  Future<Pedido?> getByIdWithDetailsAsync(String id);
}