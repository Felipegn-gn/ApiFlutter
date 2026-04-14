/// DTO de resposta contendo os dados do usuário.
class UserResponseDTO {
  final String message;
  final String status;
  final UserData? data;

  UserResponseDTO({
    required this.message,
    required this.status,
    this.data, // Opcional (Nullable)
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) {
    return UserResponseDTO(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      // Só adiciona a chave 'data' no JSON se ela não for nula
      if (data != null) 'data': data!.toJson(), 
    };
  }
}

/// Representa os dados sensíveis/públicos do usuário retornados na resposta
class UserData {
  final String name;
  final String email;

  UserData({
    required this.name,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}