import '../Enums/FormaPagamento.dart';
import '../Enums/StatusPedido.dart';
import 'Cliente.dart';
import 'Endereco.dart';
import 'ItemPedido.dart';

class Pedido {
  final String id;
  final String clienteId;
  final String enderecoEntregaId;
  final double valorTotal;
  final FormaPagamento formaPagamento;
  final StatusPedido status;
  final String observacaoGeral;
  final DateTime dataCriacao;

  // Propriedades de Navegação (Relacionamentos)
  // No Dart, usamos o tipo da classe seguido de '?' para indicar que
  // o objeto pode ou não estar carregado (lazy loading).
  final Cliente? cliente;
  final Endereco? enderecoEntrega;
  final List<ItemPedido> itensPedido;

  Pedido({
    required this.id,
    required this.clienteId,
    required this.enderecoEntregaId,
    required this.valorTotal,
    required this.formaPagamento,
    required this.status,
    this.observacaoGeral = '',
    required this.dataCriacao,
    this.cliente,
    this.enderecoEntrega,
    this.itensPedido = const [],
  });
}
