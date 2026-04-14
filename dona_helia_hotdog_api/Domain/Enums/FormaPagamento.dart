enum FormaPagamento {
  dinheiro(0),
  pix(1),
  cartaoCredito(2),
  cartaoDebito(3);

  // No Dart, podemos associar um valor (index) diretamente ao enum
  final int value;
  const FormaPagamento(this.value);

  /// Método utilitário para converter um número do banco de volta para o Enum
  factory FormaPagamento.fromInt(int index) {
    return FormaPagamento.values.firstWhere(
      (e) => e.value == index,
      orElse: () => FormaPagamento.dinheiro,
    );
  }
}