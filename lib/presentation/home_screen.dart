import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_event.dart';
import '../bloc/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        // Botón 4: esconder UI por 7s
        if (state.hideUiFor7s) {
          return Scaffold(
            appBar: AppBar(title: const Text("CleverTap - 5 Botones")),
            body: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text("Procesando... (7 segundos)"),
                ],
              ),
            ),
          );
        }

        Widget bigButton({
          required String text,
          required bool loading,
          required VoidCallback onTap,
        }) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: loading ? null : onTap,
              child: Text(loading ? "Enviando..." : text),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text("CleverTap - 5 Botones")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  bigButton(
                    text: "1️⃣ Login Usuario",
                    loading: state.b1Loading,
                    onTap: () => context.read<AppBloc>().add(PressButton1Login()),
                  ),
                  const SizedBox(height: 10),

                  bigButton(
                    text: "2️⃣ Actualizar Perfil",
                    loading: state.b2Loading,
                    onTap: () => context.read<AppBloc>().add(PressButton2UpdateProfile()),
                  ),
                  const SizedBox(height: 10),

                  bigButton(
                    text: "3️⃣ Evento Simple",
                    loading: state.b3Loading,
                    onTap: () => context.read<AppBloc>().add(PressButton3SimpleEvent()),
                  ),
                  const SizedBox(height: 10),

                  bigButton(
                    text: "4️⃣ Async (oculta UI 7s)",
                    loading: state.b4Loading,
                    onTap: () => context.read<AppBloc>().add(PressButton4AsyncDemo()),
                  ),
                  const SizedBox(height: 10),

                  // Aquí el botón 5 lo usamos para generar palabras,
                  // y añadimos aparte el switch de usuario (porque en tu versión eran 5 acciones).
                  bigButton(
                    text: "5️⃣ Generar 1–400 palabras",
                    loading: state.b5Loading,
                    onTap: () => context.read<AppBloc>().add(PressButton5GenerateWords()),
                  ),
                  const SizedBox(height: 10),

                  bigButton(
                    text: "🔁 Cambiar Usuario (extra)",
                    loading: false,
                    onTap: () => context.read<AppBloc>().add(PressButtonSwitchUser()),
                  ),

                  const SizedBox(height: 16),

                  if (state.lastMessage != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      child: Text(state.lastMessage!),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (state.randomWords.isNotEmpty) ...[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Texto generado:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(state.randomWords),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
