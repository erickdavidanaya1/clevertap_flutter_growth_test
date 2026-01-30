import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

import 'bloc/app_bloc.dart';
import 'data/clevertap_repository_impl.dart';
import 'data/clevertap_service.dart';
import 'presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) Activa logs del SDK (importante para ver qué pasa)
  CleverTapPlugin.setDebugLevel(3);

  // 2) (Opcional pero recomendado) fuerza inicialización temprana del SDK
  // Si esto te da error, lo quitamos, pero normalmente ayuda.
  try {
    await CleverTapPlugin.getCleverTapID();
    debugPrint("✅ CleverTap inicializado");
  } catch (e) {
    debugPrint("⚠️ CleverTap init warning: $e");
  }

  final service = CleverTapService();
  final repo = CleverTapRepositoryImpl(service);

  runApp(MyApp(repo: repo));
}

class MyApp extends StatelessWidget {
  final CleverTapRepositoryImpl repo;
  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(repo: repo),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}