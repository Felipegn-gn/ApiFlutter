import 'package:postgres/postgres.dart'; // Agora este vai funcionar!
import 'package:dona_helia_hotdog_api/domain/entities/adicional.dart';

class AdicionalMapper {
  /// Transforma uma linha do PostgreSQL na Entidade Adicional
  static Adicional fromRow(ResultRow row) {
    return Adicional(
      // Mapeia conforme os nomes de coluna definidos no C#
      id: row[0] as String,
      nome: row[1] as String,
      preco: (row[2] as double), // O driver converte Decimal para double
      ativo: row[3] as bool,
    );
  }

  /// Converte a Entidade para um Map de parâmetros para o INSERT/UPDATE
  static Map<String, dynamic> toMap(Adicional adicional) {
    return {
      'id': adicional.id,
      'nome': adicional.nome,
      'preco': adicional.preco,
      'ativo': adicional.ativo,
    };
  }
}

class Adicional {}
