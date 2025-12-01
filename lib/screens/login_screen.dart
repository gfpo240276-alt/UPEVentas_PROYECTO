import 'package:flutter/material.dart';
import 'package:proyecto_aplicacion_upeventas/models/option_menu_model.dart';
import 'package:proyecto_aplicacion_upeventas/models/ventas_provider.dart'
    show VentasProvider;
import 'package:proyecto_aplicacion_upeventas/themes/themes.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void displayDialog(BuildContext context) {
    showDialog(
      //para poder cerrarlo con dar clic fuera del dialog
      barrierDismissible: false,
      //ocupa el contexto
      context: context,
      //Builde es el widget
      builder: (context) {
        return AlertDialog(
          title: Text("Operación exitosa"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Datos ingresados correctamente"),
              Text("Información guardada"),
            ],
          ),
          actions: [
            TextButton(onPressed: () {}, child: Text("Aceptar")),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cerrar"),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inicio de sesión",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MainFont',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //contenedor del field
                  _Formulario(),
                ],
              ),
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
  //key del formulario
  final _keyForm = GlobalKey<FormState>();

  //controladores.

  final TextEditingController _emailCtrl = TextEditingController();

  final TextEditingController _passwordCtrl = TextEditingController();

  bool aceptado = false;

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
            hintText: "Email",
            label: "Email",
            keyboardType: TextInputType.text,
            prefixIcon: Icons.person,
            ctrl: _emailCtrl,
            textCapitalization: TextCapitalization.none,
          ),
          _MyFormField(
            hintText: "Contraseña",
            label: "Contraseña",
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: Icons.password,
            ctrl: _passwordCtrl,
            textCapitalization: TextCapitalization.none,
          ),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  final email = _emailCtrl.text.trim();
                  final password = _passwordCtrl.text.trim();

                  // Validar campos
                  if (email.isEmpty || password.isEmpty) {
                    _mostrarDialogoError(
                      context,
                      "Campos vacíos",
                      "Por favor completa todos los campos",
                    );
                    return;
                  }

                  // Verificar si hay usuarios
                  if (provider.usuarios.isEmpty) {
                    _mostrarDialogoError(
                      context,
                      "Sin usuarios",
                      "No hay usuarios registrados. Regístrate primero.",
                    );
                    return;
                  }

                  // Buscar usuario
                  Map<String, dynamic>? usuarioEncontrado;
                  for (final usuario in provider.usuarios) {
                    if (usuario['email'] == email &&
                        usuario['password'] == password) {
                      usuarioEncontrado = usuario;
                      break;
                    }
                  }

                  if (usuarioEncontrado != null) {
                    // Login exitoso

                    _emailCtrl.clear();
                    _passwordCtrl.clear();

                    // Navegar según tipo de usuario
                    if (usuarioEncontrado['vendedor'] == 1) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "CatalogoVendedor",
                        (route) => false,
                      );
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "Catalogo",
                        (route) => false,
                      );
                    }
                  } else {
                    // Login fallido
                    _mostrarDialogoFalloLogin(context);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text("Entrar", style: TextStyle(fontSize: 16)),
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
        controller: ctrl,
        autocorrect: true,
        keyboardType: keyboardType,
        obscureText: label.toLowerCase().contains("contraseña"),
        maxLines: 1,
        minLines: 1,
        textCapitalization: textCapitalization,
        validator: (data) {
          if (data!.trim().isEmpty) return "Campo requerido";

          if (label.toLowerCase().contains("email") && !data.contains("@")) {
            return "Ingresa un email válido";
          }

          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          label: Text(label),
          prefixIcon: Icon(prefixIcon, color: colorPrimario),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

// ignore: unused_element
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

void _mostrarDialogoFalloLogin(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Usuario no encontrado"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("No se ha encontrado su usuario"),
          Text("Revise sus datos"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cerrar"),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  );
}

void _mostrarDialogoError(BuildContext context, String titulo, String mensaje) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange),
          SizedBox(width: 8),
          Expanded(child: Text(titulo)),
        ],
      ),
      content: Text(mensaje),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Entendido"),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  );
}
