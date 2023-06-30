import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'db_connection.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, dynamic>> usuarios = [];

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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Aquí iría la lógica para verificar el inicio de sesión
                fetchUsuarios();
              },
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${usuarios[index]['nombre']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${usuarios[index]['id']}\n'),
                        Text('Password: ${usuarios[index]['password']}\n'),
                      ]
                    ) 
                  );
                },
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
}
