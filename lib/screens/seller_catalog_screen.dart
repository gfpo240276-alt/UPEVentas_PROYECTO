import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proyecto_aplicacion_upeventas/models/option_menu_model.dart';
import 'package:proyecto_aplicacion_upeventas/models/ventas_provider.dart';
import 'package:proyecto_aplicacion_upeventas/models/whatsapp_helper.dart';
import 'package:proyecto_aplicacion_upeventas/themes/themes.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class SellerCatalogScreen extends StatefulWidget {
  const SellerCatalogScreen({super.key});

  @override
  State<SellerCatalogScreen> createState() => _SellerCatalogScreenState();
}

class _SellerCatalogScreenState extends State<SellerCatalogScreen> {
  @override
  Widget build(BuildContext context) {
    final options = OptionMenu.optionsMenuSeller;
    Provider.of<VentasProvider>(context);
    return Scaffold(
      bottomSheet: Container(color: AppThemes.mainColor, height: 100),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, size: 30, color: Colors.black),
            );
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],

        title: Text(
          "Catálogo UPEVentas",
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
      body: Consumer<VentasProvider>(
        builder: (context, provider, child) {
          if (provider.productos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Se registró exitosamente",
                    style: TextStyle(fontFamily: "MainFont"),
                  ),
                  Text(
                    "Bienvenid(@)",
                    style: TextStyle(fontFamily: "MainFont"),
                  ),
                  SizedBox(height: 40),
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No hay productos registrados',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Da clic en contacto para conectarte con nuestros emprendedores",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "MainFont"),
                  ),
                ],
              ),
            );
          }

          // Cuando hay productos
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Se registró exitosamente",
                      style: TextStyle(fontFamily: "MainFont"),
                    ),
                    Text(
                      "Bienvenid(@)",
                      style: TextStyle(fontFamily: "MainFont"),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              // Lista de productos
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: provider.productos.length,
                  itemBuilder: (context, index) {
                    final producto = provider.productos[index];
                    return _SingleCardHighlight(
                      imgPath: producto['foto'] ?? 'assets/Paletas.jpg',
                      text: producto['descripcion'] ?? 'Sin descripción',
                      price: 'Precio: \$${producto['precio']}',
                      contacto: producto['contacto'] ?? '',
                      titulo: producto['titulo'],
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Da clic en contacto para conectarte con nuestros emprendedores",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontFamily: "MainFont"),
                ),
              ),
            ],
          );
        },
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
        Navigator.pushReplacementNamed(context, option.getRoute);
      },
    );
  }
}

class _SingleCardHighlight extends StatelessWidget {
  final String _imgPath;
  final String _text;
  final String _price;
  final String _contacto;
  final String _titulo;

  const _SingleCardHighlight({
    required String imgPath,
    required String text,
    required String price,
    required String contacto,
    required String titulo,
  }) : _imgPath = imgPath,
       _text = text,
       _price = price,
       _contacto = contacto,
       _titulo = titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.from(alpha: 1, red: 237, green: 239, blue: 243),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(.5, .5),
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: _buildImage(),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              _text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: .5,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              _price,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                letterSpacing: .5,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                // Extrae el precio del string
                final precioNum = double.tryParse(
                  _price.replaceAll(RegExp(r'[^\d.]'), ''),
                );

                await WhatsAppHelper.contactarVendedor(
                  numeroTelefono: _contacto,
                  nombreProducto: _titulo,
                  precio: precioNum,
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: Icon(Icons.phone, size: 16),
            label: Text("Contacto", style: TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              backgroundColor: Color(0xFF25D366),
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildImage() {
    // Si la ruta empieza con "assets/", es un asset
    if (_imgPath.startsWith('assets/')) {
      return Image.asset(
        _imgPath,
        height: 80,
        width: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 80,
            width: 120,
            color: Colors.grey[300],
            child: Icon(Icons.image_not_supported, color: Colors.grey),
          );
        },
      );
    }

    // Si tiene contenido, es un archivo local
    if (_imgPath.isNotEmpty) {
      return Image.file(
        File(_imgPath),
        height: 80,
        width: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 80,
            width: 120,
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.grey),
          );
        },
      );
    }

    // Imagen por defecto si no hay ruta
    return Container(
      height: 80,
      width: 120,
      color: Colors.grey[300],
      child: Icon(Icons.image, color: Colors.grey),
    );
  }
}
