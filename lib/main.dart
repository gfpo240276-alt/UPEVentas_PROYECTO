import 'package:flutter/material.dart';
import 'package:proyecto_aplicacion_upeventas/routes/routes.dart';
import 'package:proyecto_aplicacion_upeventas/screens/main_screen.dart';
import 'package:proyecto_aplicacion_upeventas/themes/themes.dart';
import 'models/ventas_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => VentasProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.temaClaro,
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.rutas,
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
    );
  }
}
