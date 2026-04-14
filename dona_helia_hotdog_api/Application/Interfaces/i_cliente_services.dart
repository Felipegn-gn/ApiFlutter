import '../Request/create_cliente_request_dto.dart';
import '../Request/create_endereco_request_dto.dart';
import '../Response/cliente_response_dto.dart';

abstract class IClienteServices {
  Future<ServiceResponse> getClienteByTelefone(String telefone);
  Future<ServiceResponse> createCliente(CreateClienteRequestDTO dto);
  Future<ServiceResponse> createEndereco(
    String clienteId,
    CreateEnderecoRequestDTO dto,
  );
}
