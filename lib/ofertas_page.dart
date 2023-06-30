import 'package:flutter/material.dart';

class OfertasPage extends StatelessWidget {
  const OfertasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas'),
      ),
      body: const Center(
        child: Text('Página de Ofertas'),
      ),
    );
  }
}