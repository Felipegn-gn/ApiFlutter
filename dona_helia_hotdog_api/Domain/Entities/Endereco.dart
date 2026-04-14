class Endereco {
  final String id;
  // A chave estrangeira (ForeignKey) que liga ao cliente
  final String clienteId; 
  // Nota: Mudei de 'rua' para 'logradouro' para manter a consistência com o seu DTO anterior
  final String logradouro; 
  final String numero;
  final String bairro;

  Endereco({
    required this.id,
    required this.clienteId,
    required this.logradouro,
    required this.numero,
    required this.bairro,
  });
}