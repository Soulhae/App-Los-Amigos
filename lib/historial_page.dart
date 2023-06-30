import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
import 'db_connection.dart';
import 'package:intl/intl.dart';

class HistorialPage extends StatefulWidget {
  final int idUsuario;

  const HistorialPage({super.key, required this.idUsuario});

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Map<String, dynamic>> productosUsuario = [];
  List<Map<String, dynamic>> producto = [];
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
              onPressed: () async {
                toggleDataVisibility();
                await fetchPurchaseHistory();
                if (isDataVisible &&
                    productosUsuario.isEmpty &&
                    context.mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('No posee productos'),
                        content:
                            const Text('El historial de compras está vacío.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Aceptar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              toggleDataVisibility();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(isDataVisible
                  ? 'Ocultar Historial de Compras'
                  : 'Mostrar Historial de Compras'),
            ),
          ),
          const SizedBox(height: 20.0),
          Visibility(
            visible: isDataVisible,
            child: Expanded(
              child: ListView.builder(
                itemCount: productosUsuario.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text('${producto[index]['nombre']}\n'),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID Producto: ${producto[index]['id']}\n'),
                            Text(
                                'Descripción: ${producto[index]['descripcion']}\n'),
                            Text(
                                'Precio unitario: \$${producto[index]['precio']}\n'),
                            Text(
                                'Cantidad: ${productosUsuario[index]['cantidad']}\n'),
                            Text(
                                'Precio total: \$${producto[index]['total']}\n'),
                            Text('Fecha de compra: ${DateFormat(productosUsuario[index]['fecha'].toString()).format(DateTime.now()).substring(0,19)}\n'),
                          ]));
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

    var result = await conn.query(
        'SELECT idProducto, cantidad, fecha FROM listaproductousuario WHERE idUsuario = ?',
        [widget.idUsuario]);
    // print(result);
    productosUsuario = result.map((r) => r.fields).toList();
    // print(productosUsuario.length);
    dynamic result2;

    for (var i = 0; i < productosUsuario.length; i++) {
      result2 = await conn.query(
          'SELECT nombre, id, descripcion, precio FROM producto WHERE id = ?',
          [productosUsuario[i]['idProducto']]);
      if (result2.isNotEmpty) {
        var productoInfo = result2.first;
        var total = productoInfo['precio'] * productosUsuario[i]['cantidad'];
        // print(total);

        producto.add({
          'nombre': productoInfo['nombre'],
          'id': productoInfo['id'],
          'descripcion': productoInfo['descripcion'],
          'precio': productoInfo['precio'],
          'total': total,
        });
      }
    }

    setState(() {});

    await conn.close();
  }

  void toggleDataVisibility() {
    setState(() {
      isDataVisible = !isDataVisible;
    });
  }
}
