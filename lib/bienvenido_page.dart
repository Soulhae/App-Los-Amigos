import 'package:flutter/material.dart';
import 'facturas_page.dart';
import 'historial_page.dart';
import 'ofertas_page.dart';

class BienvenidoPage extends StatelessWidget {
  final String nombreUsuario;
  final int idUsuario;

  const BienvenidoPage({super.key, required this.idUsuario, required this.nombreUsuario, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenid@!'), actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Ver facturas') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FacturasPage()),
              );
            } else if (value == 'Historial de compras') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistorialPage(idUsuario: idUsuario)),
              );
            } else if (value == 'Ver ofertas'){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OfertasPage()));
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Ver facturas',
              child: Text('Ver facturas'),
            ),
            const PopupMenuItem<String>(
              value: 'Ver ofertas',
              child: Text('Ver ofertas'),
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
