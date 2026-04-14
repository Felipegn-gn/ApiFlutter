import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../Application/Interfaces/i_produto_services.dart';

// Importações hipotéticas para o seu projeto
// import '../../application/interfaces/i_produto_services.dart';
// import '../../application/dtos/service_response.dart';

class ProdutosController {
  final IProdutoServices _service;
  static const _jsonHeaders = {'content-type': 'application/json'};

  // Injeção de Dependência do Serviço de Produtos
  ProdutosController(this._service);

  // Equivalente ao [Route("api/produtos")]
  Router get router {
    final router = Router();

    // Equivalente ao [HttpGet] raiz
    router.get('/', _getProdutos);

    // Equivalente ao [HttpGet("{id:guid}")]
    router.get('/<id>', _getProdutoById);

    return router;
  }

  // ---------------------------------------------------------------------------
  // HANDLERS DAS ROTAS
  // ---------------------------------------------------------------------------

  Future<Response> _getProdutos(Request request) async {
    try {
      final result = await _service.getProdutos();
      return _handleResponse(result); // Tudo resolvido em 1 linha!
    } catch (e) {
      return _internalError(e);
    }
  }

  Future<Response> _getProdutoById(Request request, String id) async {
    try {
      final result = await _service.getProdutoById(id);
      return _handleResponse(result);
    } catch (e) {
      return _internalError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // FUNÇÕES AUXILIARES (Padrão do Projeto)
  // ---------------------------------------------------------------------------

  Response _handleResponse(dynamic result, {bool isPost = false}) {
    final bodyStr = jsonEncode(result.toJson());

    switch (result.status) {
      case 'invalid_argument':
        return Response(400, body: bodyStr, headers: _jsonHeaders);
      case 'not_found':
        return Response(404, body: bodyStr, headers: _jsonHeaders);
      case 'internal_error':
      case 'error':
        return Response.internalServerError(
          body: bodyStr,
          headers: _jsonHeaders,
        );
      default:
        final statusCode = isPost ? 201 : 200;
        return Response(statusCode, body: bodyStr, headers: _jsonHeaders);
    }
  }

  Response _internalError(Object error) {
    print('Erro interno em Produtos: $error');
    return Response.internalServerError(
      body: jsonEncode({'error': 'Erro interno do servidor'}),
      headers: _jsonHeaders,
    );
  }
}
