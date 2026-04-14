/// Classe genérica para padronizar todas as respostas da API.
class ServiceResponse {
  final String status;

  // O 'dynamic' no Dart é o equivalente direto ao 'Any' do Python.
  // Pode ser uma Lista, um Map, uma String, ou null.
  final dynamic data;

  // A interrogação '?' indica que este campo é opcional (Nullable),
  // equivalente ao 'Optional[str]' no Python.
  final String? message;

  ServiceResponse({required this.status, this.data, this.message});

  /// Construtor que lê o JSON
  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      status: json['status'] ?? 'unknown',
      data: json['data'],
      message: json['message'],
    );
  }

  /// Converte o objeto para JSON, limpando campos nulos para a resposta ficar mais leve
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = {'status': status};

    // Só inclui 'data' e 'message' no JSON final se eles realmente tiverem conteúdo.
    if (data != null) {
      response['data'] = data;
    }
    if (message != null) {
      response['message'] = message;
    }

    return response;
  }
}
