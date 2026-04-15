class User {
  final String? id;
  final String name;
  final String idade;
  final String cpf;
  final String? createdAt;

  User({
    this.id,
    required this.name,
    required this.idade,
    required this.cpf,
    this.createdAt,
  });

  // Mapeia exatamente as chaves do seu JSON
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'] ?? '',
    idade: json['idade'] ?? '',
    cpf: json['cpf'] ?? '',
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {"name": name, "idade": idade, "cpf": cpf};
}
