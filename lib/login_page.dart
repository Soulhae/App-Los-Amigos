import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:soy_ese/api/firebase_api.dart';
import 'db_connection.dart';
import 'register_page.dart';
import 'bienvenido_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
              const SizedBox(width: 20.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a la página de registro al hacer clic en el botón
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text('Crear una cuenta'),
                ),
              ),
            ]),
            const SizedBox(height: 10.0),
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

  // Future<void> fetchUsuarios() async {
  //   final conn = await getConnection();

  //   Results result = await conn.query('SELECT * FROM usuario');
  //   usuarios = result.map((r) => r.fields).toList();

  //   setState(() {});

  //   await conn.close();
  // }

  Future<Results> verificarCuenta(nombreUsuario, contrasena) async {
    final conn = await getConnection();

    Results result = await conn.query(
        'SELECT id FROM usuario WHERE nombre = ? AND password = ? ',
        [nombreUsuario, contrasena]);

     setState(() {});

    await conn.close();
    return result;
  }

  Future<void> loginUsuario(BuildContext context) async {
    String nombreUsuario = userController.text;
    String contrasena = passwordController.text;
    Results usuario = await verificarCuenta(nombreUsuario, contrasena);

    if (usuario.isNotEmpty) {
      int idUsuario = usuario.first['id'];
      // print('existe');
      // print('${usuario.first['id']}');
      setState(() {
        errorMessage = '';
      });
      if (context.mounted) {
        FirebaseApi().sendNotification(
          idUsuario: idUsuario,
          nombreUsuario: nombreUsuario,
          context: context,  
        );
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BienvenidoPage(
                  idUsuario: idUsuario, nombreUsuario: nombreUsuario)),
        );
      }
    } else {
      if (nombreUsuario.isEmpty || contrasena.isEmpty) {
        // print('test');
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
      // print('no existe');

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
