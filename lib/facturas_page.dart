import 'package:flutter/material.dart';

class FacturasPage extends StatelessWidget {
  const FacturasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facturas'),
      ),
      body: const Center(
        child: Text('Página de Facturas'),
      ),
    );
  }
}