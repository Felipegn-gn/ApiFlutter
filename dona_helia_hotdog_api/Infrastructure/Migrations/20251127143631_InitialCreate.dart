import 'package:postgres/postgres.dart';

/// Equivalente a public partial class InitialCreate : Migration
class InitialCreateMigration {
  final Connection _connection;

  InitialCreateMigration(this._connection);

  /// Equivalente ao protected override void Up(MigrationBuilder migrationBuilder)
  Future<void> up() async {
    try {
      await _connection.execute('''
        CREATE TABLE IF NOT EXISTS "Users" (
          "userId" UUID PRIMARY KEY,
          "name" TEXT NOT NULL,
          "email" TEXT NOT NULL,
          "passwordHash" TEXT NOT NULL
        );
      ''');
      print(
        '✅ Migration [Up] executada: Tabela "Users" verificada/criada com sucesso.',
      );
    } catch (e) {
      print('❌ Erro na Migration [Up]: $e');
      rethrow;
    }
  }

  /// Equivalente ao protected override void Down(MigrationBuilder migrationBuilder)
  Future<void> down() async {
    try {
      await _connection.execute('DROP TABLE IF EXISTS "Users";');
      print(
        '🔄 Migration [Down] executada: Tabela "Users" removida (Rollback).',
      );
    } catch (e) {
      print('❌ Erro na Migration [Down]: $e');
      rethrow;
    }
  }
}
