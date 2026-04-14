enum StatusPedido {
  pendente(0, 'Pendente'),
  preparando(1, 'Em Preparo'),
  saiuParaEntrega(2, 'Saiu para Entrega'),
  concluido(3, 'Concluído');

  // Valor numérico para o banco de dados
  final int value;
  // Descrição amigável para exibir no app ou site
  final String descricao;

  const StatusPedido(this.value, this.descricao);

  /// Converte o índice do banco de volta para o Enum
  factory StatusPedido.fromInt(int index) {
    return StatusPedido.values.firstWhere(
      (e) => e.value == index,
      orElse: () => StatusPedido.pendente,
    );
  }
}