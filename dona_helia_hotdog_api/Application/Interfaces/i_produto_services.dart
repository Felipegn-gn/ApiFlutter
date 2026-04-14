// Importações hipotéticas dos DTOs que ficarão na pasta lib/application/dtos/

import '../Response/produto_response_dto.dart';

abstract class IProdutoServices {
  Future<ProdutoListResponseDTO> getProdutos();

  Future<ProdutoDetalhesResponseDTO> getProdutoById(String id);
}

class ProdutoDetalhesResponseDTO {}
