import 'package:postgres/postgres.dart';
import '../../domain/entities/pedido.dart';
import '../../domain/entities/item_pedido.dart';
import '../../domain/entities/item_pedido_adicional.dart';
import '../../domain/entities/item_pedido_remocao.dart';
import '../../domain/interfaces/i_pedido_repository.dart';
import '../../domain/enums/forma_pagamento.dart';
import '../../domain/enums/status_pedido.dart';

class PedidoRepository implements IPedidoRepository {
  final Connection _connection;

  PedidoRepository(this._connection);

  @override
  Future<Pedido> addAsync(Pedido pedido) async {
    // No Dart, para garantir a atomicidade (ou salva tudo ou nada), 
    // usamos uma transação manual, equivalente ao SaveChanges do EF.
    await _connection.runTx((session) async {
      // 1. Salva o cabeçalho do Pedido
      await session.execute(
        Sql.named('INSERT INTO pedidos (id, cliente_id, endereco_entrega_id, valor_total, '
            'forma_pagamento, status, observacao_geral, data_criacao) '
            'VALUES (@id, @cId, @eId, @total, @pgto, @status, @obs, @data)'),
        parameters: {
          'id': pedido.id,
          'cId': pedido.clienteId,
          'eId': pedido.enderecoEntregaId,
          'total': pedido.valorTotal,
          'pgto': pedido.formaPagamento.index,
          'status': pedido.status.index,
          'obs': pedido.observacaoGeral,
          'data': pedido.dataCriacao,
        },
      );

      // 2. Salva os Itens e seus detalhes
      for (var item in pedido.itensPedido) {
        await session.execute(
          Sql.named('INSERT INTO itens_pedido (id, pedido_id, produto_id, quantidade, '
              'preco_unitario_calculado, observacao_item) '
              'VALUES (@id, @pId, @prodId, @qtd, @preco, @obs)'),
          parameters: {
            'id': item.id,
            'pId': pedido.id,
            'prodId': item.produtoId,
            'qtd': item.quantidade,
            'preco': item.precoUnitarioCalculado,
            'obs': item.observacaoItem,
          },
        );

        // Salva Adicionais do item
        for (var add in item.adicionais) {
          await session.execute(
            Sql.named('INSERT INTO itens_pedido_adicionais (id, item_pedido_id, '
                'adicional_id, quantidade, preco_unitario_adicional) '
                'VALUES (@id, @itId, @addId, @qtd, @preco)'),
            parameters: {
              'id': add.id,
              'itId': item.id,
              'addId': add.adicionalId,
              'qtd': add.quantidade,
              'preco': add.precoUnitarioAdicional,
            },
          );
        }

        // Salva Remoções do item
        for (var rem in item.remocoes) {
          await session.execute(
            Sql.named('INSERT INTO itens_pedido_remocoes (id, item_pedido_id, ingrediente_id) '
                'VALUES (@id, @itId, @ingId)'),
            parameters: {
              'id': rem.id,
              'itId': item.id,
              'ingId': rem.ingredienteId,
            },
          );
        }
      }
    });

    return pedido;
  }

  @override
  Future<Pedido?> getByIdWithDetailsAsync(String id) async {
    // Para simplificar e manter a performance,