/// DTO de resposta para os detalhes de um produto específico
class ProdutoDetalhesResponseDTO {
  final String message;
  final String status;
  final ProdutoDetalhesData? data;

  ProdutoDetalhesResponseDTO({
    required this.message,
    required this.status,
    this.data,
  });

  factory ProdutoDetalhesResponseDTO.fromJson(Map<String, dynamic> json) {
    return ProdutoDetalhesResponseDTO(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      data: json['data'] != null
          ? ProdutoDetalhesData.fromJson(json['data'])
          : null,
    );
  }
}

/// Dados detalhados de um produto
class ProdutoDetalhesData {
  final String id;
  final String nome;
  final String descricao;
  final double precoBase;
  final String imagemUrl;
  final List<String> ingredientes;
  final List<dynamic> adicionaisDisponiveis;

  ProdutoDetalhesData({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.precoBase,
    required this.imagemUrl,
    required this.ingredientes,
    required this.adicionaisDisponiveis,
  });

  factory ProdutoDetalhesData.fromJson(Map<String, dynamic> json) {
    return ProdutoDetalhesData(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      precoBase: (json['precoBase'] ?? 0).toDouble(),
      imagemUrl: json['imagemUrl'] ?? '',
      ingredientes: List<String>.from(json['ingredientes'] ?? []),
      adicionaisDisponiveis: List<dynamic>.from(
        json['adicionaisDisponiveis'] ?? [],
      ),
    );
  }
}
