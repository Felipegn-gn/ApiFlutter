@override
  Future<Cliente?> findById(String id) async {
    // Buscamos o cliente e seus endereços em uma única pancada (JOIN)
    final result = await connection.execute(
      Sql.named(
        'SELECT c.id, c.nome, c.telefone, e.id, e.logradouro, e.numero, e.bairro '
        'FROM clientes c '
        'LEFT JOIN enderecos e ON c.id = e.cliente_id '
        'WHERE c.id = @id'
      ),
      parameters: {'id': id},
    );

    if (result.isEmpty) return null;

    // Como o JOIN pode retornar múltiplas linhas (uma para cada endereço),
    // pegamos os dados do cliente da primeira linha
    final firstRow = result.first;
    
    // Mapeamos os endereços da lista de resultados
    final listaEnderecos = result
        .where((row) => row[3] != null) // Filtra apenas se houver endereço (LEFT JOIN)
        .map((row) => Endereco(
              id: row[3] as String,
              clienteId: id,
              logradouro: row[4] as String,
              numero: row[5] as String,
              bairro: row[6] as String,
            ))
        .toList();

    return Cliente(
      id: firstRow[0] as String,
      nome: firstRow[1] as String,
      telefone: firstRow[2] as String,
      enderecos: listaEnderecos,
    );
  }