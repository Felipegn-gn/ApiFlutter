import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../Application/Interfaces/i_cliente_services.dart';

// Importações hipotéticas baseadas no seu projeto
// import '../../application/interfaces/i_cliente_services.dart';
// import '../../application/requests/create_cliente_request_dto.dart';
// import '../../application/requests/create_endereco_request_dto.dart';

class ClientesController {
  // Equivalente ao Depends() do FastAPI, nós injetamos o serviço no construtor
  final IClienteServices _service;

  // Headers padrão para retornar JSON
  static const _jsonHeaders = {'content-type': 'application/json'};

  ClientesController(this._service);

  // Equivalente ao APIRouter(prefix="/api/clientes")
  Router get router {
    final router = Router();

    // No shelf_router, usamos <variavel> ao invés de {variavel} do FastAPI
    router.get('/telefone/<telefone>', _getClienteByTelefone);
    router.post('/', _createCliente);
    router.post('/<clienteId>/enderecos', _createEndereco);

    return router;
  }

  // GET /telefone/<telefone>
  Future<Response> _getClienteByTelefone(
    Request request,
    String telefone,
  ) async {
    try {
      final result = await _service.getClienteByTelefone(telefone);
      return _handleResponse(result);
    } catch (e) {
      return _internalError(e);
    }
  }

  // POST /
  Future<Response> _createCliente(Request request) async {
    try {
      // Lê e converte o JSON que veio no corpo da requisição
      final payload = await request.readAsString();
      final data = jsonDecode(payload);

      // Aqui você instanciaria seu DTO usando os dados (ex: CreateClienteRequestDTO.fromMap(data))
      // final clienteRequest = CreateClienteRequestDTO.fromMap(data);

      // Simulação da chamada do serviço
      final result = await _service.createCliente(data); // Passe o DTO aqui

      return _handleResponse(result, isPost: true);
    } catch (e) {
      return _internalError(e);
    }
  }

  // POST /<clienteId>/enderecos
  Future<Response> _createEndereco(Request request, String clienteId) async {
    try {
      final payload = await request.readAsString();
      final data = jsonDecode(payload);

      // final enderecoRequest = CreateEnderecoRequestDTO.fromMap(data);

      final result = await _service.createEndereco(
        clienteId,
        data,
      ); // Passe o DTO aqui

      return _handleResponse(result, isPost: true);
    } catch (e) {
      return _internalError(e);
    }
  }

  // =========================================================================
  // FUNÇÕES AUXILIARES (Design Pattern para código limpo)
  // =========================================================================

  /// Equivalente ao 'match result.status' do seu Python, mas reutilizável!
  Response _handleResponse(dynamic result, {bool isPost = false}) {
    // No Dart, assumimos que 'result' tem um método toMap() ou toJson() para serializar,
    // que seria o equivalente ao 'result.__dict__' do Python.
    final bodyStr = jsonEncode(result.toJson());
    // O Dart 3 também tem pattern matching no Switch!
    switch (result.status) {
      case 'invalid_argument':
        return Response(
          400,
          body: bodyStr,
          headers: _jsonHeaders,
        ); // Bad Request
      case 'not_found':
        return Response(404, body: bodyStr, headers: _jsonHeaders); // Not Found
      case 'internal_error':
      case 'error':
        return Response.internalServerError(
          body: bodyStr,
          headers: _jsonHeaders,
        );
      default:
        // Se for um POST com sucesso, retorna 201 Created. Se for GET, retorna 200 OK.
        final statusCode = isPost ? 201 : 200;
        return Response(statusCode, body: bodyStr, headers: _jsonHeaders);
    }
  }

  /// Pega exceções não tratadas (Equivalente ao except Exception do Python)
  Response _internalError(Object error) {
    print('Erro interno: $error');
    return Response.internalServerError(
      body: jsonEncode({'error': 'Erro interno do servidor'}),
      headers: _jsonHeaders,
    );
  }
}
