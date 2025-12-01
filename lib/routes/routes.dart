import 'package:flutter/material.dart';
import 'package:proyecto_aplicacion_upeventas/screens/catalog_screen.dart';
import 'package:proyecto_aplicacion_upeventas/screens/login_screen.dart';
import 'package:proyecto_aplicacion_upeventas/screens/main_screen.dart';
import 'package:proyecto_aplicacion_upeventas/screens/registration_screen.dart';
import 'package:proyecto_aplicacion_upeventas/screens/registration_seller.dart';
import 'package:proyecto_aplicacion_upeventas/screens/screen_not_found.dart';
import 'package:proyecto_aplicacion_upeventas/screens/seller_catalog_screen.dart';

class AppRoutes {
  static final initialRoute = "inicio";

  static Map<String, Widget Function(BuildContext)> rutas = {
    "inicio": (BuildContext context) => MainScreen(),
    "login": (BuildContext context) => LoginScreen(),
    "Registrar": (BuildContext context) => RegistrationScreen(),
    "Darse de alta como vendedor": (BuildContext context) =>
        RegistrationSeller(),
    "Catalogo": (BuildContext context) => CatalogScreen(),
    "CatalogoVendedor": (BuildContext context) => SellerCatalogScreen(),
  };

  static Route<dynamic> onGenerateRoute(setting) {
    return MaterialPageRoute(builder: (context) => ScreenNotFound());
  }
}
