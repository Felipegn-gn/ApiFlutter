import '../entities/cliente.dart';
import '../entities/endereco.dart';

abstract class IClienteRepository {
  Future<Cliente?> findByTelefone(String telefone);
  Future<Cliente?> findById(String id);
  Future<void> add(Cliente cliente);
  Future<void> addEndereco(Endereco endereco);
}