import '../domain/clevertap_repository.dart';
import 'clevertap_service.dart';

class CleverTapRepositoryImpl implements CleverTapRepository {
  final CleverTapService service;

  CleverTapRepositoryImpl(this.service);

  @override
  Future<void> loginUser() {
    return service.loginUser(
      name: "Erick",
      identity: "user_1234567890",
      email: "erick@test.com",
      phone: "3000000000",
    );
  }

  @override
  Future<void> updateProfile() {
    return service.updateProfile(
      dobCleverTapFormat: r"$D_19950101",
      city: "Bogotá",
      profession: "Developer",
    );
  }

  @override
  Future<void> eventSimple() {
    return service.recordSimpleEvent("Boton_3_Click");
  }

  @override
  Future<void> eventWithProps() {
    return service.recordEventWithProps("Compra", {
      "Producto": "Curso Flutter",
      "Monto": 99,
      "Moneda": "USD",
      "MetodoPago": "Tarjeta",
    });
  }

  @override
  Future<void> switchUser() {
    return service.loginUser(
      name: "Maria",
      identity: "user_999",
      email: "maria@test.com",
      phone: "3111111111",
    );
  }

  // ✅ NUEVO
  @override
  Future<void> asyncOcultaUI7s() {
    return service.asyncOcultaUI7s();
  }

  // ✅ NUEVO
  @override
  Future<void> generateText1400({int requestedWords = 400}) {
    return service.generateText1400(requestedWords: requestedWords);
  }
}
