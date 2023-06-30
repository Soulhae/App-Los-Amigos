import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar Contraseña',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: registerUser,
              child: const Text('Registrarse'),
            ),
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

   void registerUser() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, complete todos los campos.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        errorMessage = 'Las contraseñas no coinciden.';
      });
      return;
    }

    // Faltan verificaciones, para dps enviar a la bd

    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    setState(() {
      errorMessage = '';
    });
  }
}