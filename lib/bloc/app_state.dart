import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool b1Loading;
  final bool b2Loading;
  final bool b3Loading;
  final bool b4Loading;
  final bool b5Loading;

  final bool hideUiFor7s;        // para el botón 4 (ocultar UI)
  final String? lastMessage;     // mensajes tipo "ok / error"
  final String randomWords;      // salida del botón 5

  const AppState({
    required this.b1Loading,
    required this.b2Loading,
    required this.b3Loading,
    required this.b4Loading,
    required this.b5Loading,
    required this.hideUiFor7s,
    required this.lastMessage,
    required this.randomWords,
  });

  factory AppState.initial() => const AppState(
        b1Loading: false,
        b2Loading: false,
        b3Loading: false,
        b4Loading: false,
        b5Loading: false,
        hideUiFor7s: false,
        lastMessage: null,
        randomWords: "",
      );

  AppState copyWith({
    bool? b1Loading,
    bool? b2Loading,
    bool? b3Loading,
    bool? b4Loading,
    bool? b5Loading,
    bool? hideUiFor7s,
    String? lastMessage,
    String? randomWords,
    bool clearMessage = false,
  }) {
    return AppState(
      b1Loading: b1Loading ?? this.b1Loading,
      b2Loading: b2Loading ?? this.b2Loading,
      b3Loading: b3Loading ?? this.b3Loading,
      b4Loading: b4Loading ?? this.b4Loading,
      b5Loading: b5Loading ?? this.b5Loading,
      hideUiFor7s: hideUiFor7s ?? this.hideUiFor7s,
      lastMessage: clearMessage ? null : (lastMessage ?? this.lastMessage),
      randomWords: randomWords ?? this.randomWords,
    );
  }

  @override
  List<Object?> get props => [
        b1Loading,
        b2Loading,
        b3Loading,
        b4Loading,
        b5Loading,
        hideUiFor7s,
        lastMessage,
        randomWords,
      ];
}
