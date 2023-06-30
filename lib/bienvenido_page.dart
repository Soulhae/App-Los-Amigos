import 'package:flutter/material.dart';
import 'invoices_page.dart';
import 'historial_page.dart';

class BienvenidoPage extends StatelessWidget {
  final String nombreUsuario;

  const BienvenidoPage({super.key, required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenid@!'), actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Ver facturas') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InvoicesPage()),
              );
            } else if (value == 'Historial de compras') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistorialPage()),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Ver facturas',
              child: Text('Ver facturas'),
            ),
            const PopupMenuItem<String>(
              value: 'Historial de compras',
              child: Text('Historial de compras'),
            ),
          ],
        ),
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¡Bienvenid@, $nombreUsuario!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://media.discordapp.net/attachments/821058935325851678/1098066060818788422/Sin_titulo.gif',
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
