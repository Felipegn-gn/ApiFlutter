import 'endereco.dart';

class Cliente {
  final String id;
  final String nome;
  final String telefone;
  
  // O equivalente ao relationship() do SQLAlchemy.
  // Uma lista para armazenar os endereços associados a este cliente.
  final List<Endereco> enderecos;

  Cliente({
    required this.id,
    required this.nome,
    required this.telefone,
    // Inicia como uma lista vazia caso o cliente seja novo e ainda não tenha endereço
    this.enderecos = const [], 
  });
}