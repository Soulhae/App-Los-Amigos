import 'package:flutter/material.dart';
import 'db_connection.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de Usuario',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar Contraseña',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => registerUser(context),
              child: const Text('Registrarse'),
            ),
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

  Future<void> registerUser(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
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

    if (password != confirmPassword) {
      setState(() {
        errorMessage = 'Las contraseñas no coinciden.';
      });
      Future.delayed(const Duration(seconds: 5)).then((value) {
        setState(() {
          errorMessage = '';
        });
      });
      return;
    }

    // Faltan verificaciones, para dps enviar a la bd
    final conn = await getConnection();

    try {
      await conn.query(
        'INSERT INTO usuario (nombre, password) VALUES (?, ?)',
        [username, password],
      );

      // Mostrar un mensaje de éxito
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Éxito'),
              content: const Text('Usuario registrado correctamente.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('ERRO EAORAEIRJASD JOERERRORO ERRROOOOOOOOOOR!!!!!!!! OJO $e');
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('No se pudo registrar el usuario.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    await conn.close();

    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    setState(() {
      errorMessage = '';
    });
  }
}