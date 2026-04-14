class PedidoResumoResponseDTO {
  final String id;
  final String clienteNome;
  // Adicionei os outros campos que são comuns em um resumo de pedido
  final String? enderecoEntregaFormatado;
  final double? valorTotal;

  PedidoResumoResponseDTO({
    required this.id,
    required this.clienteNome,
    this.enderecoEntregaFormatado,
    this.valorTotal,
    required List<dynamic> descricaoCustomizacao,
  });

  // Esse método ajuda a transformar o objeto em JSON para enviar pela API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clienteNome': clienteNome,
      'enderecoEntregaFormatado': enderecoEntregaFormatado,
      'valorTotal': valorTotal,
    };
  }
}
