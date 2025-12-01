import 'package:flutter/material.dart';

class OptionMenu {
  final String route;
  final String optName;
  final IconData icon;

  OptionMenu(this.route, this.optName, this.icon);

  /// Menú para cliente normal
  static final optionsMenu = [
    OptionMenu("Catalogo", "Catálogo", Icons.store),
    OptionMenu("inicio", "Cerrar sesión", Icons.logout),
  ];

  /// Menú para vendedor (actualizado con todas las opciones)
  static final optionsMenuSeller = [
    OptionMenu("CatalogoVendedor", "Mis productos", Icons.store_mall_directory),

    OptionMenu("AgregarProducto", "Agregar producto", Icons.add_box_outlined),

    OptionMenu("EditarProducto", "Editar producto", Icons.edit),

    OptionMenu("EliminarProducto", "Eliminar producto", Icons.delete_forever),

    OptionMenu("inicio", "Cerrar sesión", Icons.logout),
  ];

  String get getRoute => route;
  String get getOptName => optName;
  IconData get getIcon => icon;
}
