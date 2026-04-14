import 'package:uuid/uuid.dart';

class User {
  // Atributos privados para simular o 'private set' do C#
  final String _id;
  final String _name;
  final String _email;
  final String _passwordHash;

  // Getters públicos para leitura
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get passwordHash => _passwordHash;

  // Construtor principal (Equivalente ao construtor com parâmetros do C#)
  User({
    required String name,
    required String email,
    required String passwordHash,
    String? id, // Opcional: permite passar um ID se estiver vindo do banco
  })  : _id = id ?? const Uuid().v4(),
        _name = name,
        _email = email,
        _passwordHash = passwordHash;

  // Construtor vazio (Equivalente ao User() {} do C#)
  // No Dart, geralmente usamos construtores nomeados para clareza
  factory User.empty() {
    return User(
      name: '',
      email: '',
      passwordHash: '',
      id: '',
    );
  }
}