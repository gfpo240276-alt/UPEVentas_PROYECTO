import 'package:flutter/material.dart';
import 'package:proyecto_aplicacion_upeventas/models/ventas_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  void displayDialog(BuildContext context) {
    showDialog(
      //para poder cerrarlo con dar clic fuera del dialog
      barrierDismissible: false,
      //ocupa el contexto
      context: context,
      //Builder es el widget
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
          "Registro de Usuario",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MainFont',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
  final TextEditingController _nombreCtrl = TextEditingController();

  final TextEditingController _emailCtrl = TextEditingController();

  final TextEditingController _celCtrl = TextEditingController();

  final TextEditingController _passwordCtrl = TextEditingController();

  final TextEditingController _addressCtrl = TextEditingController();

  bool aceptado = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Limpiar los controladores cuando el widget se destruya
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _celCtrl.dispose();
    _passwordCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
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
            hintText: "Nombre Completo",
            label: "Nombre Completo",
            keyboardType: TextInputType.text,
            prefixIcon: Icons.person,
            ctrl: _nombreCtrl,
            textCapitalization: TextCapitalization.none,
          ),
          _MyFormField(
            hintText: "Teléfono",
            label: "Teléfono",
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.person,
            ctrl: _celCtrl,
            textCapitalization: TextCapitalization.none,
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
          _MyFormField(
            hintText: "Dirección",
            label: "Dirección",
            keyboardType: TextInputType.text,
            prefixIcon: Icons.place,
            ctrl: _addressCtrl,
            textCapitalization: TextCapitalization.none,
          ),

          SwitchListTile(
            value: aceptado,
            title: Text("Darse de alta como vendedor"),
            onChanged: (value) {
              setState(() {
                aceptado = value;
              });
            },
          ),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                if (_keyForm.currentState!.validate()) {
                  final nombre = _nombreCtrl.text.trim();
                  final email = _emailCtrl.text.trim();
                  final telefono = _celCtrl.text.trim();
                  final password = _passwordCtrl.text.trim();
                  final direccion = _addressCtrl.text.trim();

                  if (nombre.isEmpty && email.isEmpty) {
                    _mostrarDialogoError(
                      context,
                      "Datos incompletos",
                      "Por favor, ingresa información en los campos",
                    );
                    return;
                  }

                  await provider.guardarUsuario(
                    nombre,
                    email,
                    telefono,
                    password,
                    direccion,
                    aceptado,
                  );

                  // Limpiar después de guardar
                  _nombreCtrl.clear();
                  _emailCtrl.clear();
                  _celCtrl.clear();
                  _passwordCtrl.clear();
                  _addressCtrl.clear();

                  // ignore: use_build_context_synchronously
                  _mostrarDialogoExito(context, aceptado);
                }
              },
              child: Text("Guardar"),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyFormField extends StatefulWidget {
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
  State<_MyFormField> createState() => __MyFormFieldState();
}

class __MyFormFieldState extends State<_MyFormField> {
  @override
  Widget build(BuildContext context) {
    Color colorPrimario = Theme.of(context).colorScheme.primary;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: widget.ctrl,
        autocorrect: true,
        keyboardType: widget.keyboardType,
        obscureText: widget.label.toLowerCase().contains("contraseña"),
        maxLines: widget.label.toLowerCase().contains("dirección") ? 3 : 1,
        minLines: 1,
        textCapitalization: widget.textCapitalization,
        validator: (data) {
          if (data!.trim().isEmpty) return "Campo requerido";

          if (widget.label.toLowerCase().contains("email") &&
              !data.contains("@")) {
            return "Ingresa un email válido";
          }

          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          label: Text(widget.label),
          prefixIcon: Icon(widget.prefixIcon, color: colorPrimario),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

void _mostrarDialogoExito(BuildContext context, bool esVendedor) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text("¡Registro exitoso!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tu cuenta ha sido creada correctamente"),
          SizedBox(height: 8),
          Text(
            esVendedor
                ? "Ahora puedes registrar tus productos"
                : "Bienvenido al catálogo",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (esVendedor) {
              Navigator.pushReplacementNamed(
                context,
                "Darse de alta como vendedor",
              );
            } else {
              Navigator.pushReplacementNamed(context, "Catalogo");
            }
          },
          child: Text("Continuar"),
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
