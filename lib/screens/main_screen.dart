import 'package:flutter/material.dart';
import 'package:proyecto_aplicacion_upeventas/models/option_menu_model.dart';
import 'package:proyecto_aplicacion_upeventas/themes/themes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(color: AppThemes.mainColor, height: 100),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "UPEVentas",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MainFont',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Image(image: AssetImage("assets/logo.png")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "Registrar");
                  },
                  child: Text("Registrar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  child: Text("Iniciar Sesión"),
                ),
              ],
            ),
          ],
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
