import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../Application/Interfaces/i_user_services.dart';

// Importações hipotéticas para o seu projeto
// import '../../application/interfaces/i_user_services.dart';
// import '../../application/dtos/user_request_dto.dart';
// import '../../application/dtos/service_response.dart';

class UserController {
  final IUserServices _service;
  static const _jsonHeaders = {'content-type': 'application/json'};

  // Injeção de Dependência do Serviço de Usuários
  UserController(this._service);

  // Equivalente ao [Route("api/users")]
  Router get router {
    final router = Router();

    // Equivalente ao [HttpPost] raiz
    router.post('/', _registerUser);

    return router;
  }

  // ---------------------------------------------------------------------------
  // HANDLERS DAS ROTAS
  // ---------------------------------------------------------------------------

  Future<Response> _registerUser(Request request) async {
    try {
      // Lê o body da requisição
      final payload = await request.readAsString();
      final data = jsonDecode(payload);

      // Aqui você instanciaria seu DTO para garantir a tipagem forte
      // final userRequestDTO = UserRequestDTO.fromMap(data);

      // Chama a camada de aplicação
      final result = await _service.createUser(data); // Passe o DTO aqui

      return _handleResponse(result, isPost: true);
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
        // Como a rota de registro é um POST, o sucesso retorna 201 Created
        final statusCode = isPost ? 201 : 200;
        return Response(statusCode, body: bodyStr, headers: _jsonHeaders);
    }
  }

  Response _internalError(Object error) {
    print('Erro interno em Users: $error');
    return Response.internalServerError(
      body: jsonEncode({'error': 'Erro interno do servidor'}),
      headers: _jsonHeaders,
    );
  }
}
