import '../Interfaces/i_produto_services.dart';
import '../Response/produto_response_dto.dart';

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

  factory ProdutoDetalhesResponseDTO.fromJson(
    Map<String, dynamic> json,
    dynamic produto,
  ) {
    return ProdutoDetalhesResponseDTO(
      status: 'success',
      message: 'Produto carregado com sucesso',
      data: ProdutoDetalhesData(
        id: produto.id,
        nome: produto.nome,
        precoBase: produto.precoBase,
        ingredientes: produto.ingredientes
            .map((i) => i.nome)
            .toList(), // Lista para o cliente escolher o que remover
        adicionaisDisponiveis: produto
            .adicionais, // Lista para o cliente escolher o que pagar a mais
        imagemUrl: produto.imagemUrl,
        descricao: produto.descricao,
      ),
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

class ProdutoService implements IProdutoServices {
  // Injeção de Dependências usando dynamic temporariamente
  final dynamic _produtoRepository;

  ProdutoService(this._produtoRepository);

  @override
  Future<ProdutoListResponseDTO> getProdutos() async {
    try {
      // Busca os produtos ativos
      final produtos = await _produtoRepository.getActiveAsync();

      // Mapeia a lista de entidades para a lista de DTOs
      final produtosData = (produtos as List).map((produto) {
        return ProdutoCatalogoData(
          id: produto.id,
          nome: produto.nome,
          descricao: produto.descricao,
          precoBase: produto.precoBase,
          imagemUrl: produto.imagemUrl,
        );
      }).toList();

      return ProdutoListResponseDTO(
        message: 'Products retrieved successfully',
        status: 'success',
        data: produtosData,
      );
    } catch (ex) {
      return ProdutoListResponseDTO(
        message: 'An error occurred: $ex',
        status: 'error',
      );
    }
  }

  @override
  Future<ProdutoDetalhesResponseDTO> getProdutoById(String id) async {
    try {
      final produto = await _produtoRepository.getByIdAsync(id);

      return ProdutoDetalhesResponseDTO.fromJson({}, produto);
    } catch (ex) {
      return ProdutoDetalhesResponseDTO(
        message: 'An error occurred: $ex',
        status: 'error',
      );
    }
  }
}
