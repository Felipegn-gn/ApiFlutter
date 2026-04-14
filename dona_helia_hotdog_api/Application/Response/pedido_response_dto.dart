/// DTO de resposta para a criação de um pedido
class CreatePedidoResponseDTO {
  final String message;
  final String status;
  final CreatePedidoData? data;

  CreatePedidoResponseDTO({
    required this.message,
    required this.status,
    this.data,
  });

  factory CreatePedidoResponseDTO.fromJson(Map<String, dynamic> json) {
    return CreatePedidoResponseDTO(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      data: json['data'] != null ? CreatePedidoData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

/// Dados retornados após criar um pedido
class CreatePedidoData {
  final String id;

  CreatePedidoData({required this.id});

  factory CreatePedidoData.fromJson(Map<String, dynamic> json) {
    return CreatePedidoData(
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}