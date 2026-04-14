import 'package:postgres/postgres.dart';
import '../../domain/entities/user.dart';
import '../../domain/interfaces/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final Connection _connection;

  UserRepository(this._connection);

  @override
  Future<User> addAsync(User user) async {
    // Equivalente ao _context.Users.Add(user) e SaveChangesAsync()
    await _connection.execute(
      Sql.named(
        'INSERT INTO users (id, name, email, password_hash) '
        'VALUES (@id, @name, @email, @pwHash)'
      ),
      parameters: {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'pwHash': user.passwordHash,
      },
    );

    return user;
  }
}