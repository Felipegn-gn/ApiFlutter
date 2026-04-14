import 'package:postgres/postgres.dart';
import '../persistence/database_manager.dart';
import '../repositories/user_repository.dart';
import '../repositories/produto_repository.dart';
import '../repositories/adicional_repository.dart';
import '../repositories/cliente_repository.dart';
import '../repositories/endereco_repository.dart';
import '../repositories/pedido_repository.dart';

/// Classe que centraliza o acesso a todas as "tabelas",
/// equivalente ao AppDbContext do Entity Framework no C#.
class AppDbContext {
  final DatabaseManager _dbManager;

  // Os "DbSet<T>" do C# se transformam em instâncias dos Repositórios no Dart
  late final UserRepository users;
  late final ProdutoRepository produtos;
  late final AdicionalRepository adicionais;
  late final ClienteRepository clientes;
  late final EnderecoRepository enderecos;
  late final PedidoRepository pedidos;

  AppDbContext(this._dbManager);

  /// Inicializa o contexto e injeta a conexão do banco em todos os repositórios
  Future<void> initialize() async {
    // 1. Garante que o banco está conectado
    await _dbManager.init();
    final Connection conn = _dbManager.connection;

    // 2. Instancia as "tabelas" (Repositórios) com a conexão ativa
    users = UserRepository(conn);
    produtos = ProdutoRepository(conn);
    adicionais = AdicionalRepository(conn);
    clientes = ClienteRepository(conn);
    enderecos = EnderecoRepository(conn);
    pedidos = PedidoRepository(conn);

    print('📦 AppDbContext inicializado com todos os repositórios carregados!');
  }

  /// Equivalente ao Dispose() do C# para fechar a conexão
  Future<void> dispose() async {
    await _dbManager.close();
  }
}
