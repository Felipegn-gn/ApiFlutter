// Importações hipotéticas para o seu projeto
// import '../../application/interfaces/i_pedido_services.dart';
// import '../../application/dtos/create_pedido_request_dto.dart';
// import '../../application/dtos/service_response.dart';

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../Application/Interfaces/i_pedido_services.dart';

class PedidosController {
  final IPedidoServices _service;
  static const _jsonHeaders = {'content-type': 'application/json'};

  // Construtor com injeção de dependência
  PedidosController(this._service);

  // Equivalente ao [Route("api/pedidos")] e mapeamento de métodos HTTP
  Router get router {
    final router = Router();

    // Equivalente ao [HttpPost]
    router.post('/', _createPedido);

    // Equivalente ao [HttpGet("{id:guid}")]
    router.get('/<id>', _getPedidoById);

    return router;
  }

  // ---------------------------------------------------------------------------
  // HANDLERS DAS ROTAS
  // ---------------------------------------------------------------------------

  Future<Response> _createPedido(Request request) async {
    try {
      final payload = await request.readAsString();
      final data = jsonDecode(payload);

      // Instanciação do DTO (Adapte conforme o nome exato do seu arquivo/classe)
      // final pedidoRequestDTO = CreatePedidoRequestDTO.fromMap(data);

      final result = await _service.createPedido(data); // Passaria o DTO aqui

      return _handleResponse(result, isPost: true);
    } catch (e) {
      return _internalError(e);
    }
  }

  Future<Response> _getPedidoById(Request request, String id) async {
    try {
      // O Dart captura o <id> da URL como String.
      // A validação se é um UUID válido geralmente acontece lá no Service.
      final result = await _service.getPedidoById(id);

      return _handleResponse(result);
    } catch (e) {
      return _internalError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // FUNÇÕES AUXILIARES (Design Pattern)
  // ---------------------------------------------------------------------------

  /// Centraliza o 'switch' do C# num lugar só!
  Response _handleResponse(dynamic result, {bool isPost = false}) {
    // Usando o toJson() que você aprimorou na nossa última conversa!
    final bodyStr = jsonEncode(result.toJson());

    switch (result.status) {
      case 'invalid_argument':
        return Response(
          400,
          body: bodyStr,
          headers: _jsonHeaders,
        ); // BadRequest
      case 'not_found':
        return Response(404, body: bodyStr, headers: _jsonHeaders); // NotFound
      case 'internal_error':
      case 'error':
        return Response.internalServerError(
          body: bodyStr,
          headers: _jsonHeaders,
        ); // StatusCode 500
      default:
        final statusCode = isPost
            ? 201
            : 200; // 201 Created para POST, 200 Ok para GET
        return Response(statusCode, body: bodyStr, headers: _jsonHeaders);
    }
  }

  Response _internalError(Object error) {
    print('Erro interno em Pedidos: $error');
    return Response.internalServerError(
      body: jsonEncode({'error': 'Erro interno do servidor'}),
      headers: _jsonHeaders,
    );
  }
}
