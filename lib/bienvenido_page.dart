import 'package:flutter/material.dart';
import 'facturas_page.dart';
import 'historial_page.dart';
import 'ofertas_page.dart';

class BienvenidoPage extends StatelessWidget {
  final String nombreUsuario;
  final int idUsuario;

  const BienvenidoPage({super.key, required this.idUsuario, required this.nombreUsuario, });
  static const route = '/bienvenido-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenid@!'), actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Boletas y/o facturas') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FacturasPage(idUsuario: idUsuario)),
              );
            } else if (value == 'Historial de compras') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistorialPage(idUsuario: idUsuario)),
              );
            } else if (value == 'Ofertas activas'){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfertasPage(idUsuario: idUsuario)));
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Boletas y/o facturas',
              child: Text('Boletas y/o facturas'),
            ),
            const PopupMenuItem<String>(
              value: 'Ofertas activas',
              child: Text('Ofertas activas'),
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
            Image.asset(
              'assets/image.png',
              height: 300,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
