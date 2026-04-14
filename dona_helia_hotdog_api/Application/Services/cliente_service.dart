import '../Interfaces/i_cliente_services.dart';
import '../Request/create_cliente_request_dto.dart';
import '../Response/cliente_response_dto.dart';
import 'package:uuid/uuid.dart';
import '../Request/create_endereco_request_dto.dart';

/// Implementação do serviço de clientes usando a palavra-chave 'implements'
class ClienteService implements IClienteServices {
  // Inicializa o gerador de UUID
  final Uuid _uuid = Uuid();

  // Simulando um banco de dados na memória (exatamente como no Python)
  final List<Map<String, dynamic>> _clientes = [];
  final List<Map<String, dynamic>> _enderecos = [];

  @override
  Future<ServiceResponse> getClienteByTelefone(String telefone) async {
    // 1. Validação básica de regra de negócio
    if (telefone.length < 8) {
      return ServiceResponse(
        status: 'invalid_argument',
        message: 'Telefone inválido.',
      );
    }

    // 2. Busca o cliente
    // O 'where' filtra a lista. Se não achar, o 'isEmpty' será verdadeiro.
    final matches = _clientes.where((c) => c['telefone'] == telefone);

    if (matches.isEmpty) {
      return ServiceResponse(
        status: 'not_found',
        message: 'Cliente não cadastrado na base.',
      );
    }

    // Retorna o primeiro cliente encontrado
    return ServiceResponse(status: 'success', data: matches.first);
  }

  @override
  Future<ServiceResponse> createCliente(CreateClienteRequestDTO dto) async {
    // Regra: Não permitir duplicidade de telefone
    final existente = await getClienteByTelefone(dto.telefone);

    if (existente.status == 'success') {
      return ServiceResponse(
        status: 'invalid_argument',
        message: 'Este telefone já está cadastrado.',
      );
    }

    // Criação do objeto
    final novoCliente = {
      'id': _uuid.v4(), // Gera o UUID versão 4
      'nome': dto.nome,
      'telefone': dto.telefone,
    };

    _clientes.add(novoCliente);

    return ServiceResponse(status: 'success', data: novoCliente);
  }

  @override
  Future<ServiceResponse> createEndereco(
    String clienteId,
    CreateEnderecoRequestDTO dto,
  ) async {
    // Regra: Verificar se o cliente realmente existe antes de add endereço
    final clienteExiste = _clientes.any((c) => c['id'] == clienteId);

    if (!clienteExiste) {
      return ServiceResponse(
        status: 'not_found',
        message: 'Cliente não encontrado para este endereço.',
      );
    }

    final novoEndereco = {
      'id': _uuid.v4(),
      'cliente_id': clienteId,
      // Nota: Usei 'logradouro' e 'complemento' para bater com o DTO que fizemos em Dart
      'logradouro': dto.logradouro,
      'numero': dto.numero,
      'bairro': dto.bairro,
      'complemento': dto.complemento,
    };

    _enderecos.add(novoEndereco);

    return ServiceResponse(status: 'success', data: novoEndereco);
  }
}
