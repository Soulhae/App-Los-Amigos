import 'package:flutter/material.dart';
import 'login_page.dart';
import 'invoices_page.dart';
import 'historial_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Inicio'),
        actions: <Widget>[
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
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Contenido de la página de inicio'),
      ),
    );
  }
}