import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/user_service.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final UserService _service = UserService();
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();
    try {
      _users = await _service.getUsers();
    } catch (e) {
      debugPrint("Erro no Provider: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> add(User user) async {
    try {
      await _service.createUser(user);
      await fetchUsers(); // Recarrega a lista após criar
    } catch (e) {
      debugPrint("Erro ao adicionar: $e");
    }
  }

  Future<void> remove(String id) async {
    try {
      await _service.deleteUser(id);
      await fetchUsers(); // Recarrega a lista após deletar
    } catch (e) {
      debugPrint("Erro ao remover: $e");
    }
  }
}
