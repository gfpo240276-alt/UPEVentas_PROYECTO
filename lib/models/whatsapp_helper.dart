// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  // Abre WhatsApp con un número específico
  static Future<void> abrirWhatsApp({
    required String numeroTelefono,
    String mensaje = '',
  }) async {
    // Limpia el número (elimina espacios, guiones, paréntesis)
    String numeroLimpio = numeroTelefono.replaceAll(RegExp(r'[^\d+]'), '');

    // Si el número no tiene código de país, agrégalo (ejemplo: México +52)
    if (!numeroLimpio.startsWith('+')) {
      numeroLimpio = '+52$numeroLimpio'; // Cambia 52 por tu código de país
    }

    // Codifica el mensaje para URL
    String mensajeCodificado = Uri.encodeComponent(mensaje);

    // URL de WhatsApp
    final url = 'https://wa.me/$numeroLimpio?text=$mensajeCodificado';
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // Abre en la app de WhatsApp
        );
      } else {
        throw 'No se pudo abrir WhatsApp';
      }
    } catch (e) {
      print('Error al abrir WhatsApp: $e');
      throw 'Error al abrir WhatsApp. Asegúrate de tener WhatsApp instalado.';
    }
  }

  // Versión alternativa: abre chat sin mensaje predefinido
  static Future<void> abrirChatWhatsApp(String numeroTelefono) async {
    await abrirWhatsApp(numeroTelefono: numeroTelefono);
  }

  // Versión con mensaje predefinido
  static Future<void> contactarVendedor({
    required String numeroTelefono,
    required String nombreProducto,
    double? precio,
  }) async {
    String mensaje = 'Hola! Me interesa tu producto: $nombreProducto';
    if (precio != null) {
      mensaje += ' (\$$precio)';
    }

    await abrirWhatsApp(numeroTelefono: numeroTelefono, mensaje: mensaje);
  }
}
