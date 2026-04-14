// Importações hipotéticas dos DTOs que ficarão na pasta lib/application/dtos/

import '../Request/user_request_dto.dart';
import '../Response/user_response_dto.dart';

abstract class IUserServices {
  /// Cria um novo usuário no sistema
  Future<UserResponseDTO> createUser(UserRequestDTO user);
}
