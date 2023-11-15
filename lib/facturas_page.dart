import 'package:flutter/material.dart';

import 'db_connection.dart';
import 'package:intl/intl.dart';

class FacturasPage extends StatefulWidget {
  final int idUsuario;

  const FacturasPage({super.key, required this.idUsuario});

  @override
  _FacturasPageState createState() => _FacturasPageState();
}

class _FacturasPageState extends State<FacturasPage> {
  List<Map<String, dynamic>> facturasUsuario = [];
  List<Map<String, dynamic>> venta = [];
  List<Map<String, dynamic>> producto = [];
  bool isDataVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de facturas'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                toggleDataVisibility();
                await fetchPurchaseHistory();
                if (isDataVisible && facturasUsuario.isEmpty && mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('No posee facturas'),
                        content:
                            const Text('El listado de facturas está vacío.'),
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
                  ? 'Ocultar Facturas'
                  : 'Mostrar Facturas'),
            ),
          ),
          const SizedBox(height: 20.0),
          Visibility(
            visible: isDataVisible,
            child: Expanded(
              child: ListView.builder(
                itemCount: facturasUsuario.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text('Factura ${facturasUsuario[index]['id']}\n'),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text('Fecha: ${DateFormat(facturasUsuario[index]['fecha'].toString()).format(DateTime.now()).substring(0, 10)}\n'),
                            Text(
                                'Producto: ${producto[index]['nombre']}\n'),
                            Text(
                                'Precio unitario: \$${producto[index]['precio']}\n'),
                            Text(
                                'Cantidad: ${venta[index]['cantidad']}\n'),
                            Text(
                                'Precio total: \$${producto[index]['total']}\n'),
                            Text(
                                'Fecha de vencimiento: ${DateFormat(facturasUsuario[index]['fechaVencimiento'].toString()).format(DateTime.now()).substring(0, 10)}\n'),
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
        'SELECT id, idVenta, fecha, fechaVencimiento FROM factura WHERE idUsuario = ?',
        [widget.idUsuario]);
    // print(result);
    facturasUsuario = result.map((r) => r.fields).toList();
    // print(productosUsuario.length);
    dynamic result2;
    dynamic result3;

    for (var i = 0; i < facturasUsuario.length; i++){
      result2 = await conn.query(
        'SELECT idProducto, cantidad FROM listaproductousuario WHERE id = ?',
        [facturasUsuario[i]['idVenta']]);
      if(result2.isNotEmpty){
        var ventaInfo = result2.first;
        venta.add({
          'idProducto': ventaInfo['idProducto'],
          'cantidad': ventaInfo['cantidad']
        });
      }
    }

    for (var i = 0; i < venta.length; i++){
      result3 = await conn.query(
        'SELECT nombre, precio FROM productoOld where id = ?',
        [venta[i]['idProducto']]);
      if (result3.isNotEmpty){
        var productoInfo2 = result3.first;
        var total2 = productoInfo2['precio'] * venta[i]['cantidad'];
        // print(total);

        producto.add({
          'nombre': productoInfo2['nombre'],
          'precio': productoInfo2['precio'],
          'total': total2,
        });
      }
    }

    // for (var i = 0; i < facturasUsuario.length; i++) {
    //   result2 = await conn.query(
    //       'SELECT nombre, id, descripcion, precio FROM producto WHERE id = ?',
    //       [facturasUsuario[i]['idProducto']]);
    //   if (result2.isNotEmpty) {
        // var productoInfo = result2.first;
        // var total = productoInfo['precio'] * facturasUsuario[i]['cantidad'];
        // // print(total);

        // producto.add({
        //   'nombre': productoInfo['nombre'],
        //   'id': productoInfo['id'],
        //   'descripcion': productoInfo['descripcion'],
        //   'precio': productoInfo['precio'],
        //   'total': total,
        // });
    //   }
    // }

    setState(() {});

    await conn.close();
  }

  void toggleDataVisibility() {
    setState(() {
      isDataVisible = !isDataVisible;
    });
  }

}