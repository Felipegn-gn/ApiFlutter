import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

// Importe os seus controllers aqui (ajuste o caminho se necessário)
// import '../lib/presentation/controllers/clientes_controller.dart';
// import '../lib/presentation/controllers/pedidos_controller.dart';
// import '../lib/presentation/controllers/produtos_controller.dart';
// import '../lib/presentation/controllers/user_controller.dart';

void main() async {
  print('🌭 Iniciando o sistema da Dona Helia...');

  // =========================================================================
  // 1. INJEÇÃO DE DEPENDÊNCIA
  // =========================================================================
  // Quando seus repositórios e serviços estiverem prontos, instancie-os aqui:
  // final clienteService = ClienteServices(clienteRepository);
  // final clientesController = ClientesController(clienteService);

  // final pedidoService = PedidoServices(pedidoRepository);
  // final pedidosController = PedidosController(pedidoService);

  // final produtoService = ProdutoServices(produtoRepository);
  // final produtosController = ProdutosController(produtoService);

  // final userService = UserServices(userRepository);
  // final userController = UserController(userService);

  // =========================================================================
  // 2. REGISTRO DE ROTAS
  // =========================================================================
  final appRouter = Router();

  // Rota de teste simples para garantir que o servidor está funcionando
  appRouter.get('/ping', (Request request) {
    return Response.ok('Pong! A API da Dona Helia está online! 🌭');
  });

  // Descomente estas linhas para plugar suas rotas reais no servidor
  // appRouter.mount('/api/clientes', clientesController.router);
  // appRouter.mount('/api/pedidos', pedidosController.router);
  // appRouter.mount('/api/produtos', produtosController.router);
  // appRouter.mount('/api/users', userController.router);

  // =========================================================================
  // 3. MIDDLEWARE E START DO SERVIDOR
  // =========================================================================

  // Pipeline que intercepta as requisições e faz o log no terminal
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(appRouter.call);

  // Sobe o servidor na porta 8080
  final server = await io.serve(handler, 'localhost', 8080);

  print(
    '🚀 Servidor online! Ouvindo em http://${server.address.host}:${server.port}',
  );
}
