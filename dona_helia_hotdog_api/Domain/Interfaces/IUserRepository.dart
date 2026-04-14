import '../entities/user.dart';

/// Interface de contrato para o repositório de Usuários (Staff/Admin).
abstract class IUserRepository {
  /// Salva um novo usuário no banco de dados e retorna a instância persistida.
  /// Equivalente ao Task<User> do C#.
  Future<User> addAsync(User user);
}