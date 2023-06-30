import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'db_connection.dart';

class HistorialPage extends StatefulWidget {
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Map<String, dynamic>> purchaseHistory = [];
  bool isDataVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Compras'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
            onPressed: () {
              toggleDataVisibility();
              fetchPurchaseHistory();
            },
            child: Text(isDataVisible ? 'Ocultar Historial de Compras' : 'Mostrar Historial de Compras'),
            ),
          ),
          const SizedBox(height: 20.0),
          Visibility(
            visible: isDataVisible,
            child: Expanded(
              child: ListView.builder(
                itemCount: purchaseHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${purchaseHistory[index]['nombre']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${purchaseHistory[index]['id']}\n'),
                        Text('Descripción: ${purchaseHistory[index]['descripcion']}\n'),
                        Text('Precio: \$${purchaseHistory[index]['precio']}\n'),
                        Text('Usuario asociado: ${purchaseHistory[index]['id_usuario']}\n')
                      ]
                    ) 
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchPurchaseHistory() async {
    final conn = await getConnection();

    Results result = await conn.query('SELECT * FROM producto');
    purchaseHistory = result.map((r) => r.fields).toList();

    setState(() {});

    await conn.close();
  }

  void toggleDataVisibility() {
    setState(() {
      isDataVisible = !isDataVisible;
    });
  }
}
