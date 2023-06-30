import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'db_connection.dart';
import 'register_page.dart';
import 'bienvenido_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, dynamic>> usuarios = [];
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20.0),
            Row(children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () => loginUsuario(context),
                  child: const Text('Iniciar Sesión'),
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a la página de registro al hacer clic en el botón
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: const Text('Crear una cuenta'),
                ),
              ),
            ]),
            SizedBox(height: 10.0),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUsuarios() async {
    final conn = await getConnection();

    Results result = await conn.query('SELECT * FROM usuario');
    usuarios = result.map((r) => r.fields).toList();

    setState(() {});

    await conn.close();
  }

  Future<bool> verificarCuenta(nombreUsuario, contrasena) async {
    final conn = await getConnection();

    Results result = await conn.query(
        'SELECT id FROM usuario WHERE nombre = ? AND password = ? ',
        [nombreUsuario, contrasena]);

    setState(() {});

    await conn.close();
    return result.isNotEmpty;
  }

  Future<void> loginUsuario(BuildContext context) async {
    String nombreUsuario = userController.text;
    String contrasena = passwordController.text;
    bool usuarioExiste = await verificarCuenta(nombreUsuario, contrasena);

    if (usuarioExiste) {
      print('existe');
      setState(() {
        errorMessage = '';
      });
      if(context.mounted) {
        Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => BienvenidoPage(nombreUsuario: nombreUsuario)),
      );
      }
    } else {
      if (nombreUsuario.isEmpty || contrasena.isEmpty) {
        setState(() {
          errorMessage = 'Por favor, complete todos los campos.';
        });
        Future.delayed(const Duration(seconds: 5)).then((value) {
          setState(() {
            errorMessage = '';
          });
        });
        return;
      }
      print('no existe');
      setState(() {
        errorMessage = 'Usuario ingresado no se encuentra registrado.';
        Future.delayed(const Duration(seconds: 5)).then((value) {
          setState(() {
            errorMessage = '';
          });
        });
      });
    }
  }
}
