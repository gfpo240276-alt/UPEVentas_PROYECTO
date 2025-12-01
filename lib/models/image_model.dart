import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class ImageModel {
  final ImagePicker _picker = ImagePicker();

  //Clase para obtener imagenes de la galeria
  Future<String?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Compresion para ahorrar espacio
      );
      
      if (image == null) return null;
      
      return await _saveImageLocally(image);
    } catch (e) {
      return null;
    }
  }

  // Tomar foto con cámara
  Future<String?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      
      if (image == null) return null;
      
      return await _saveImageLocally(image);
    } catch (e) {
      return null;
    }
  }

  // Guardar imagen localmente y retornar la ruta
  Future<String> _saveImageLocally(XFile image) async {
    // Obtener directorio de documentos de la app
    final Directory appDir = await getApplicationDocumentsDirectory();
    
    // Crear carpeta para imágenes si no existe
    final Directory imageDir = Directory('${appDir.path}/imagenes');
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }
    
    // Generar nombre único generando con momento de creacion
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String extension = path.extension(image.path);
    final String fileName = 'img_$timestamp$extension';
    final String savedPath = '${imageDir.path}/$fileName';
    
    // Copiar imagen al directorio local
    await File(image.path).copy(savedPath);
    
    return savedPath; // La ruta que se guardara en la BD
  }

  // Eliminar imagen del almacenamiento local
  Future<bool> deleteImage(String imagePath) async {
    try {
      final File file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}