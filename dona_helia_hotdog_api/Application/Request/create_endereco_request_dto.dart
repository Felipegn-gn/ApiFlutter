/// DTO para a criação de um novo endereço.
class CreateEnderecoRequestDTO {
  final String logradouro;
  final String numero;
  final String bairro;
  final String complemento;

  CreateEnderecoRequestDTO({
    required this.logradouro,
    required this.numero,
    required this.bairro,
    this.complemento = '', // Opcional por padrão, já inicia vazio se não for passado
  });

  /// Construtor que lê o JSON (substitui o comportamento do [JsonPropertyName])
  factory CreateEnderecoRequestDTO.fromJson(Map<String, dynamic> json) {
    return CreateEnderecoRequestDTO(
      logradouro: json['logradouro'] ?? '',
      numero: json['numero'] ?? '',
      bairro: json['bairro'] ?? '',
      // Se o complemento vier nulo no JSON, garantimos que ele seja uma string vazia
      complemento: json['complemento'] ?? '', 
    );
  }

  /// Converte o objeto de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
    };
  }
}