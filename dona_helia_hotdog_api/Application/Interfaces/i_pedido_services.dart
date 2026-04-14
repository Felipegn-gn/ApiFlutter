import '../Response/cliente_response_dto.dart';

import '../Request/create_pedido_request_dto.dart';

abstract class IPedidoServices {
  // 1. O parâmetro deve ser o Pedido completo, não apenas o Item.
  // 2. O retorno deve ser ServiceResponse para bater com o seu Service.
  Future<ServiceResponse> createPedido(
    CreatePedidoItemRequestDTO pedidoRequestDTO,
  );

  // 3. Aqui também usamos ServiceResponse para manter o padrão da arquitetura.
  Future<ServiceResponse> getPedidoById(String id);
}
