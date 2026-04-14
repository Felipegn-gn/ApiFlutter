/// DTO para a criação ou atualização de um usuário (ex: funcionário ou admin).
class UserRequestDTO {
  final String name;
  final String email;
  final String password;

  UserRequestDTO({
    required this.name,
    required this.email,
    required this.password,
  });

  /// Construtor que lê o JSON (substitui o comportamento do [JsonPropertyName])
  factory UserRequestDTO.fromJson(Map<String, dynamic> json) {
    return UserRequestDTO(
      // O ?? '' substitui o '= string.Empty;' do C#, garantindo que não seja nulo
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  /// Converte o objeto de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}