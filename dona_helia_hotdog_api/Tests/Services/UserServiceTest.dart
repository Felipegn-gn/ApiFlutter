import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

// Importe os seus arquivos reais aqui. Ajuste os caminhos conforme sua estrutura:
// import 'package:dona_helia_hotdog_api/application/services/user_service.dart';
// import 'package:dona_helia_hotdog_api/application/requests/user_request_dto.dart';
// import 'package:dona_helia_hotdog_api/domain/repositories/user_repository.dart';
// import 'package:dona_helia_hotdog_api/application/interfaces/security_service.dart';
// import 'package:dona_helia_hotdog_api/domain/entities/user.dart';

// 1. Criando os "Substitutes" (Mocks)
class MockUserRepository extends Mock implements UserRepository {}

class MockSecurityService extends Mock implements SecurityService {}

// Uma classe falsa necessária pelo mocktail para registrar tipos complexos no 'any()'
class FakeUser extends Fake implements User {}

void main() {
  // Configuração inicial (Equivalente ao construtor public UserServiceTest())
  late MockUserRepository mockUserRepository;
  late MockSecurityService mockSecurityService;
  late UserService service;

  // Roda antes de CADA [Fact]
  setUp(() {
    // Registra o tipo User para o mocktail entender quando usarmos 'any()'
    registerFallbackValue(FakeUser());

    mockUserRepository = MockUserRepository();
    mockSecurityService = MockSecurityService();
    service = UserService(mockUserRepository, mockSecurityService);
  });

  // Equivalente ao [Fact]
  test('Should Create New User Correctly', () async {
    // Arrange
    final request = UserRequestDTO(
      name: "Felipe Souza",
      email: "felipe@gmail.com",
      password:
          "felipe123@#\$", // Escape do $ porque no Dart ele injeta variáveis
    );

    final passwordHashMock = "HIE2233";

    // Equivalente a _userServices.HashPassword(request.Password).Returns(...)
    when(
      () => mockSecurityService.hashPassword(request.password),
    ).thenReturn(passwordHashMock);

    // Também mockamos o repositório para ele não tentar salvar de verdade (apenas fingir que salvou)
    when(
      () => mockUserRepository.addAsync(any()),
    ).thenAnswer((_) async => Future.value());

    // Act
    final result = await service.createUser(request);

    // Assert (Equivalente aos Assert.Equal)
    expect(result.message, "User created successfully");
    expect(result.status, "Success");
    expect(result.data?.name, request.name);
    expect(result.data?.email, request.email);
  });

  // Equivalente ao [Fact]
  test('Should Return Invalid Argument When Request Is Null', () async {
    // Arrange
    UserRequestDTO? request; // Null por padrão

    // Act
    final result = await service.createUser(request);

    // Assert
    expect(result.message, "Parameters is empty or null");
    expect(result.status, "invalid_argument");
    expect(result.data, isNull);
  });

  // Equivalente ao [Fact]
  test(
    'CreateUser When Repository Throws Exception Returns Error Response',
    () async {
      // Arrange
      final request = UserRequestDTO(
        name: "Felipe Souza",
        email: "felipe@gmail.com",
        password: "felipe123@#\$",
      );

      // Equivalente a Arg.Any<string>() do NSubstitute
      when(() => mockSecurityService.hashPassword(any())).thenReturn("hash123");

      // Equivalente ao .ThrowsAsync(...)
      when(
        () => mockUserRepository.addAsync(any()),
      ).thenThrow(Exception("DB error"));

      // Act
      final result = await service.createUser(request);

      // Assert
      expect(result.status, "error");
      expect(result.data, isNull);
    },
  );
}
