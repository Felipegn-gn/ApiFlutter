// Importação hipotética do seu Enum. 
// Ajuste o caminho conforme onde você criou a pasta 'enums'.
// import '../../domain/enums/forma_pagamento.dart';

/// Caso ainda não tenha o Enum criado, aqui está um exemplo de como ele seria:
enum FormaPagamento { dinheiro, cartaoCredito, cartaoDebito, pix }

class CreatePedidoRequestDTO {
  final String clienteId;
  final String enderecoEntregaId;
  final FormaPagamento formaPagamento;
  final String observacaoGeral;
  final List<CreatePedidoItemRequestDTO> itens;

  CreatePedidoRequestDTO({
    required this.clienteId,
    required this.enderecoEntregaId,
    required this.formaPagamento,
    this.observacaoGeral = '',
    this.itens = const [], // Garante que nunca seja null, inicializando vazia
  });

  factory CreatePedidoRequestDTO.fromJson(Map<String, dynamic> json) {
    return CreatePedidoRequestDTO(
      clienteId: json['clienteId'] ?? '',
      enderecoEntregaId: json['enderecoEntregaId'] ?? '',
      
      // Lendo um Enum do JSON (assumindo que ele vem como uma String, ex: "pix")
      formaPagamento: FormaPagamento.values.firstWhere(
        (e) => e.name == json['formaPagamento'],
        orElse: () => FormaPagamento.dinheiro, // Valor padrão de segurança
      ),
      
      observacaoGeral: json['observacaoGeral'] ?? '',
      
      // Conversão segura de Lista de JSON para Lista de Objetos Dart
      itens: (json['itens'] as List?)
              ?.map((item) => CreatePedidoItemRequestDTO.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clienteId': clienteId,
      'enderecoEntregaId': enderecoEntregaId,
      'formaPagamento': formaPagamento.name, // Converte o Enum de volta para String
      'observacaoGeral': observacaoGeral,
      'itens': itens.map((item) => item.toJson()).toList(), // Converte a lista de objetos para JSON
    };
  }
}

class CreatePedidoItemRequestDTO {
  final String produtoId;
  final int quantidade;
  final String observacaoItem;
  final List<String> ingredientesRemovidos;
  final List<CreatePedidoItemAdicionalRequestDTO> adicionais;

  CreatePedidoItemRequestDTO({
    required this.produtoId,
    required this.quantidade,
    this.observacaoItem = '',
    this.ingredientesRemovidos = const [],
    this.adicionais = const [],
  });

  factory