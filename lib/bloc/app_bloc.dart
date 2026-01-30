import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/clevertap_repository.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final CleverTapRepository repo;

  AppBloc({required this.repo}) : super(AppState.initial()) {
    on<PressButton1Login>(_onB1Login);
    on<PressButton2UpdateProfile>(_onB2Profile);
    on<PressButton3SimpleEvent>(_onB3SimpleEvent);
    on<PressButton4AsyncDemo>(_onB4AsyncDemo);
    on<PressButton5GenerateWords>(_onB5Words);
    on<PressButtonSwitchUser>(_onSwitchUser);
  }

  Future<void> _onB1Login(PressButton1Login event, Emitter<AppState> emit) async {
    if (state.b1Loading) return;
    emit(state.copyWith(b1Loading: true, lastMessage: "Enviando Login...", clearMessage: false));
    try {
      await repo.loginUser();
      emit(state.copyWith(lastMessage: "✅ Login enviado"));
    } catch (e) {
      emit(state.copyWith(lastMessage: "❌ Error Login: $e"));
      debugPrint("$e");
    } finally {
      emit(state.copyWith(b1Loading: false));
    }
  }

  Future<void> _onB2Profile(PressButton2UpdateProfile event, Emitter<AppState> emit) async {
    if (state.b2Loading) return;
    emit(state.copyWith(b2Loading: true, lastMessage: "Enviando Profile...", clearMessage: false));
    try {
      await repo.updateProfile();
      emit(state.copyWith(lastMessage: "✅ Profile actualizado"));
    } catch (e) {
      emit(state.copyWith(lastMessage: "❌ Error Profile: $e"));
    } finally {
      emit(state.copyWith(b2Loading: false));
    }
  }

  Future<void> _onB3SimpleEvent(PressButton3SimpleEvent event, Emitter<AppState> emit) async {
    if (state.b3Loading) return;
    emit(state.copyWith(b3Loading: true, lastMessage: "Enviando evento simple...", clearMessage: false));
    try {
      await repo.eventSimple();
      emit(state.copyWith(lastMessage: "✅ Evento simple enviado"));
    } catch (e) {
      emit(state.copyWith(lastMessage: "❌ Error Evento simple: $e"));
    } finally {
      emit(state.copyWith(b3Loading: false));
    }
  }

  /// Botón 4: Oculta la UI 7s + muestra loader + luego vuelve y deja mensaje
  Future<void> _onB4AsyncDemo(PressButton4AsyncDemo event, Emitter<AppState> emit) async {
  if (state.b4Loading) return;

  emit(state.copyWith(
    b4Loading: true,
    hideUiFor7s: true,
    lastMessage: "⏳ Ejecutando async (7s)...",
    clearMessage: false,
  ));

  try {
    // ✅ Aquí se manda a CleverTap + espera 7s
    await repo.asyncOcultaUI7s();

    emit(state.copyWith(
      hideUiFor7s: false,
      lastMessage: "✅ Async terminado (7s) + enviado a CleverTap",
    ));
  } catch (e) {
    emit(state.copyWith(
      hideUiFor7s: false,
      lastMessage: "❌ Error async: $e",
    ));
  } finally {
    emit(state.copyWith(b4Loading: false));
  }
}

  /// Botón 5: Genera entre 1 y 400 palabras aleatorias y las muestra debajo
  Future<void> _onB5Words(PressButton5GenerateWords event, Emitter<AppState> emit) async {
  if (state.b5Loading) return;
  emit(state.copyWith(b5Loading: true, lastMessage: "Generando texto...", clearMessage: false));

  try {
    final words = _generateRandomWords();

    // ✅ manda evento a CleverTap con “requested=400”
    await repo.generateText1400(requestedWords: 400);

    emit(state.copyWith(
      randomWords: words,
      lastMessage: "✅ Texto generado + evento enviado a CleverTap",
    ));
  } catch (e) {
    emit(state.copyWith(lastMessage: "❌ Error texto: $e"));
  } finally {
    emit(state.copyWith(b5Loading: false));
  }
}

  Future<void> _onSwitchUser(PressButtonSwitchUser event, Emitter<AppState> emit) async {
    // lo podemos enganchar al botón 5 de "cambiar usuario" en UI
    try {
      await repo.switchUser();
      emit(state.copyWith(lastMessage: "✅ Usuario cambiado"));
    } catch (e) {
      emit(state.copyWith(lastMessage: "❌ Error cambio usuario: $e"));
    }
  }

  String _generateRandomWords() {
    const bank = [
      "flutter","bloc","clean","architecture","async","state","event","profile","button","debugger",
      "clevertap","mobile","android","dart","widget","stream","repository","service","domain","data",
      "presentation","pattern","logic","testing","integration","eventprops","identity","login","update",
      "random","words","generate","engineer","growth","operations","app","session","device","token"
    ];

    final rnd = Random();
    final count = rnd.nextInt(400) + 1; // 1..400

    return List.generate(count, (_) => bank[rnd.nextInt(bank.length)]).join(" ");
  }
}