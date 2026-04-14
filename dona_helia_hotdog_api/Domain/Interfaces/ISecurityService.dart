/// Interface de contrato para serviços de segurança e criptografia.
abstract class ISecurityService {
  /// Recebe uma senha em texto puro e retorna a representação criptografada (Hash).
  String hashPassword(String password);
  
  /// Dica: No Dart, costumamos adicionar também a verificação na interface:
  // bool verifyPassword(String password, String hash);
}