// Importação hipotética da entidade de relacionamento (se você for mapeá-la no domínio)
// import 'item_pedido_adicional.dart';

class Adicional {
  final String id;
  final String nome;
  final double preco;
  final bool ativo;
  
  // No Dart, o equivalente a ICollection é uma List.
  // Muitas vezes em arquiteturas limpas no Dart, evitamos acoplar entidades 
  // bidirecionalmente, mas se você precisar da lista de itens, ela seria assim:
  // final List<ItemPedidoAdicional> itensPedidoAdicional;

  Adicional({
    required this.id,
    required this.nome,
    required this.preco,
    this.ativo = true, // Define como verdadeiro por padrão ao instanciar
    // this.itensPedidoAdicional = const [], // Inicia a lista vazia por padrão
  });

  // Exemplo de uma Regra de Negócio Pura (DDD) opcional:
  // Um método para desativar o adicional
  Adicional desativar() {
    return Adicional(
      id: this.id,
      nome: this.nome,
      preco: this.preco,
      ativo: false,
    );
  }
}