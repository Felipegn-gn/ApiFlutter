import 'package:dio/dio.dart';
import '../models/user.dart';

class UserService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://69deca16d6de26e119282d31.mockapi.io/api/v1/flutter',
      connectTimeout: const Duration(seconds: 10),
    ),
  );

  // Rota específica solicitada: /teste
  final String _endpoint = '/teste';

  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get(_endpoint);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => User.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Falha ao carregar usuários: $e');
    }
  }

  Future<void> createUser(User user) async {
    try {
      await _dio.post(_endpoint, data: user.toJson());
    } catch (e) {
      throw Exception('Erro ao salvar: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _dio.put('$_endpoint/${user.id}', data: user.toJson());
    } catch (e) {
      throw Exception('Erro ao editar: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete('$_endpoint/$id');
    } catch (e) {
      throw Exception('Erro ao remover: $e');
    }
  }
}
