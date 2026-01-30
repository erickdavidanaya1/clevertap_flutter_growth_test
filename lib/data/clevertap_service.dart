import 'package:flutter/foundation.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

class CleverTapService {
  CleverTapService() {
    // Útil para ver logs en consola
    CleverTapPlugin.setDebugLevel(3);
  }

  Future<void> loginUser({
    required String name,
    required String identity,
    required String email,
    required String phone,
  }) async {
    debugPrint("👉 CT loginUser: $identity");
    await CleverTapPlugin.onUserLogin({
      "Name": name,
      "Identity": identity,
      "Email": email,
      "Phone": phone,
    });
  }

  Future<void> updateProfile({
    required String dobCleverTapFormat, // ejemplo: $D_19950101
    required String city,
    required String profession,
  }) async {
    debugPrint("👉 CT updateProfile");
    await CleverTapPlugin.profileSet({
      "DOB": dobCleverTapFormat,
      "City": city,
      "Profession": profession,
    });
  }

  Future<void> recordSimpleEvent(String eventName) async {
    debugPrint("👉 CT recordSimpleEvent: $eventName");
    await CleverTapPlugin.recordEvent(eventName, {});
  }

  Future<void> recordEventWithProps(
    String eventName,
    Map<String, dynamic> props,
  ) async {
    debugPrint("👉 CT recordEventWithProps: $eventName");
    await CleverTapPlugin.recordEvent(eventName, props);
  }

  // Async (oculta UI 7s)
  Future<void> asyncOcultaUI7s() async {
    debugPrint("👉 CT Async_UI_Start");

    await CleverTapPlugin.recordEvent("Async_UI_Start", {
      "duration_sec": 7,
      "source": "flutter",
    });

    // Simula que la UI queda "ocupada" 7s
    await Future.delayed(const Duration(seconds: 7));

    await CleverTapPlugin.recordEvent("Async_UI_End", {
      "duration_sec": 7,
      "result": "ok",
      "source": "flutter",
    });

    debugPrint("✅ CT Async_UI_End");
  }

  // Generar texto 1-400 palabras
  Future<void> generateText1400({int requestedWords = 400}) async {
    // requestedWords entre 1 y 400
    final req = requestedWords.clamp(1, 400);

    debugPrint("👉 CT Generate_Text (requested=$req)");

    // Simula "generación" (no mandes el texto completo como prop)
    final startMs = DateTime.now().millisecondsSinceEpoch;

    await Future.delayed(const Duration(milliseconds: 600));

    final endMs = DateTime.now().millisecondsSinceEpoch;
    final latencyMs = endMs - startMs;

    // Simula que "generaste" req palabras (sin enviar texto)
    await CleverTapPlugin.recordEvent("Generate_Text", {
      "requested_words": req,
      "generated_words": req,
      "latency_ms": latencyMs,
      "result": "ok",
      "source": "flutter",
    });

    debugPrint("✅ CT Generate_Text (latency=${latencyMs}ms)");
  }
}

