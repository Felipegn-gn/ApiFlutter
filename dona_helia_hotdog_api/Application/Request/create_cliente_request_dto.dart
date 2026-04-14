class CreateClienteRequestDTO {
  final String nome;
  final String telefone;

  CreateClienteRequestDTO({required this.nome, required this.telefone});

  /// Transforma o JSON que vem da web neste Objeto
  factory CreateClienteRequestDTO.fromMap(Map<String, dynamic> map) {
    return CreateClienteRequestDTO(
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
    );
  }
}
