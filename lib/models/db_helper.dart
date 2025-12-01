// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'upeventas2.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // Tabla de usuarios
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            telefono TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            direccion TEXT NOT NULL,
            vendedor INTEGER DEFAULT 0,
            fecha_registro TEXT
          )
        ''');

        // Tabla de productos
        await db.execute('''
          CREATE TABLE productos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            descripcion TEXT NOT NULL,
            precio REAL NOT NULL,
            foto TEXT,
            contacto TEXT,
            fecha_registro TEXT
          )
        ''');
      },
    );
  }

  // USUARIOS
  Future<int> insertarUsuario(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('usuarios', data);
  }

  Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
    final db = await database;
    return await db.query('usuarios', orderBy: 'id DESC');
  }

  Future<int> eliminarUsuario(int id) async {
    final db = await database;
    return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }

  // PRODUCTOS
  Future<int> insertarProducto(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('productos', data);
  }

  Future<List<Map<String, dynamic>>> obtenerProductos() async {
    final db = await database;
    return await db.query('productos', orderBy: 'id DESC');
  }

  Future<int> eliminarProducto(int id) async {
    final db = await database;
    return await db.delete('productos', where: 'id = ?', whereArgs: [id]);
  }

  Future getDB() async {}

  Future<void> actualizarUsuario(int id, Map<String, String> data) async {
    final db = await database;
    await db.update('usuarios', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> actualizarProducto(int id, Map<String, dynamic> data) async {
    final db = await database;
    await db.update('productos', data, where: 'id = ?', whereArgs: [id]);
  }
}
