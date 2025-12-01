import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:proyecto_aplicacion_upeventas/models/option_menu_model.dart';
import 'package:proyecto_aplicacion_upeventas/models/ventas_provider.dart';
import 'package:proyecto_aplicacion_upeventas/themes/themes.dart';

class RegistrationSeller extends StatelessWidget {
  const RegistrationSeller({super.key});

  @override
  Widget build(BuildContext context) {
    final options = OptionMenu.optionsMenuSeller;
    Provider.of<VentasProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registra tu Producto",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MainFont',
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 60, 20, 30),
                decoration: BoxDecoration(
                  color: AppThemes.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.store,
                        size: 40,
                        color: Color(0xFFEAAC8B),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'UPEVentas',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MainFont',
                      ),
                    ),
                    Text(
                      'Compra y vende fácil',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Lista de opciones
              Expanded(
                child: Container(
                  color: AppThemes.mainColor,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) =>
                        _OptionMenu(option: options[index]),
                    itemCount: options.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_Formulario()],
            ),
          ),
        ),
      ),
    );
  }
}

class _Formulario extends StatefulWidget {
  const _Formulario();
  @override
  State<_Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<_Formulario> {
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _tituloCtrl = TextEditingController();
  final TextEditingController _descripcionCtrl = TextEditingController();
  final TextEditingController _precioCtrl = TextEditingController();
  final TextEditingController _contactoCtrl = TextEditingController();

  bool aceptado = false;

  void _mostrarDialogoExito(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Operación exitosa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Datos ingresados correctamente"),
            Text("Información guardada"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "CatalogoVendedor");
            },
            child: Text("Aceptar e ir al catalogo"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Registrar otro producto"),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VentasProvider>(context);
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: Image(image: AssetImage("assets/logo.png")),
          ),
          _MyFormField(
            hintText: "Titulo del producto",
            label: "Titulo del producto",
            keyboardType: TextInputType.text,
            prefixIcon: Icons.title,
            ctrl: _tituloCtrl,
            textCapitalization: TextCapitalization.none,
          ),

          //Visualizacion de la imagen a subir o vacia.
          Consumer<VentasProvider>(
            builder: (context, provider, child) {
              if (provider.imagePath != null &&
                  provider.imagePath!.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(provider.imagePath!),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Colors.red.shade300,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Error al cargar imagen',
                                    style: TextStyle(
                                      color: Colors.red.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Botón para eliminar imagen
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Material(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              provider.limpiarImagen();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // Placeholder cuando no hay imagen
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No hay imagen seleccionada',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: provider.seleccionarImagenGaleria,
                icon: Icon(Icons.photo_library),
                label: Text('Galería'),
              ),
              ElevatedButton.icon(
                onPressed: provider.tomarFoto,
                icon: Icon(Icons.camera_alt),
                label: Text('Cámara'),
              ),
            ],
          ),
          _MyFormField(
            hintText: "Descripción del producto",
            label: "Descripción",
            keyboardType: TextInputType.text,
            prefixIcon: Icons.description,
            ctrl: _descripcionCtrl,
            textCapitalization: TextCapitalization.sentences,
          ),
          _MyFormField(
            hintText: "Precio del producto",
            label: "Precio",
            keyboardType: TextInputType.number,
            prefixIcon: Icons.attach_money,
            ctrl: _precioCtrl,
            textCapitalization: TextCapitalization.none,
          ),
          _MyFormField(
            hintText: "Número de contacto",
            label: "Contacto",
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone,
            ctrl: _contactoCtrl,
            textCapitalization: TextCapitalization.none,
          ),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                if (_keyForm.currentState!.validate()) {
                  provider.guardarProducto(
                    _tituloCtrl.text,
                    _descripcionCtrl.text,
                    _contactoCtrl.text,
                    double.parse(_precioCtrl.text),
                  );

                  _tituloCtrl.clear();
                  _descripcionCtrl.clear();
                  _contactoCtrl.clear();
                  _precioCtrl.clear();

                  _mostrarDialogoExito(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEAAC8B),
              ),
              child: Text("Guardar"),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
              ),
              child: Text("Regresar", style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyFormField extends StatelessWidget {
  final String hintText;
  final String label;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final TextCapitalization textCapitalization;
  final TextEditingController ctrl;

  const _MyFormField({
    required this.hintText,
    required this.label,
    required this.keyboardType,
    required this.prefixIcon,
    required this.ctrl,
    required this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    Color colorPrimario = Theme.of(context).colorScheme.primary;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autocorrect: true,
        keyboardType: keyboardType,
        maxLines: 3,
        minLines: 1,
        textCapitalization: textCapitalization,
        controller: ctrl,
        validator: (data) {
          if (data!.trim().isEmpty) return "Campo requerido";
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          label: Text(label),
          prefixIcon: Icon(prefixIcon, color: colorPrimario),
        ),
      ),
    );
  }
}

class _OptionMenu extends StatelessWidget {
  final OptionMenu option;

  const _OptionMenu({required this.option});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(option.getOptName, style: TextStyle(color: Colors.black)),
      leading: Icon(option.getIcon, color: AppThemes.fourthColor),
      onTap: () {
        Navigator.pushNamed(context, option.getRoute);
      },
    );
  }
}
