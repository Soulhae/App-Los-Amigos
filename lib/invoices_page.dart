import 'package:flutter/material.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

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