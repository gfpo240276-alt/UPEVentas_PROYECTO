import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:proyecto_aplicacion_upeventas/models/image_model.dart';
import 'db_helper.dart';

class VentasProvider extends ChangeNotifier {
  final DBHelper _db = DBHelper();

  List<Map<String, dynamic>> usuarios = [];
  List<Map<String, dynamic>> productos = [];
  String? imagePath;
  final ImageModel _imageModel = ImageModel();

  bool get tieneImagen => imagePath != null && imagePath!.isNotEmpty;

  VentasProvider() {
    cargarTodo();
  }

  Future<void> cargarTodo() async {
    await cargarUsuarios();
    await cargarProductos();
  }

  // USUARIOS
  Future<void> cargarUsuarios() async {
    usuarios = await _db.obtenerUsuarios();
    notifyListeners();
  }

  Future<void> guardarUsuario(
    String nombre,
    String email,
    String telefono,
    String password,
    String direccion,
    bool vendedor,
  ) async {
    final fecha = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final data = {
      'nombre': nombre,
      'telefono': telefono,
      'email': email,
      'password': password,
      'direccion': direccion,
      'vendedor': vendedor ? 1 : 0,
      'fecha_registro': fecha,
    };
    await _db.insertarUsuario(data);
    await cargarUsuarios();
  }

  bool esUsuarioVendedor(Map<String, dynamic> usuario) {
    return usuario['vendedor'] == 1;
  }

  Future<void> eliminarUsuario(int id) async {
    await _db.eliminarUsuario(id);
    await cargarUsuarios();
  }

  Future<void> cargarProductos() async {
    productos = await _db.obtenerProductos();
    notifyListeners();
  }

  Future<void> guardarProducto(
    String titulo,
    String descripcion,
    String contacto,
    double precio,
  ) async {
    final fecha = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final data = {
      'titulo': titulo,
      'descripcion': descripcion,
      'precio': precio,
      'foto': imagePath ?? '',
      'contacto': contacto,
      'fecha_registro': fecha,
    };


    await _db.insertarProducto(data);
    limpiarImagen();
    await cargarProductos();
  }

  Future<void> eliminarProducto(int id) async {
    final producto = productos.firstWhere((p) => p['id'] == id);
    if (producto['foto'] != null && producto['foto'].isNotEmpty) {
      await _imageModel.deleteImage(producto['foto']);
    }
    await _db.eliminarProducto(id);
    await cargarProductos();
  }

  Future<void> editarUsuario(
    int id,
    String nombre,
    String email,
    String telefono,
    String password,
    String direccion,
  ) async {
    final data = {
      'nombre': nombre,
      'telefono': telefono,
      'email': email,
      'password': password,
      'direccion': direccion,
    };
    await _db.actualizarUsuario(id, data);
    await cargarUsuarios();
  }

  Future<void> editarProducto(
    int id,
    String titulo,
    String descripcion,
    String contacto,
    double precio,
  ) async {
    final data = {
      'titulo': titulo,
      'descripcion': descripcion,
      'precio': precio,
      'foto': imagePath ?? '',
      'contacto': contacto,
    };
    await _db.actualizarProducto(id, data);
    await cargarProductos();
  }

  Future<void> seleccionarImagenGaleria() async {
    final path = await _imageModel.pickImageFromGallery();
    if (path != null) {
      imagePath = path;
      notifyListeners();
    }
  }

  Future<void> tomarFoto() async {
    final path = await _imageModel.pickImageFromCamera();
    if (path != null) {
      imagePath = path;
      notifyListeners();
    }
  }

  void limpiarImagen() {
    imagePath = null;
    notifyListeners();
  }
}
