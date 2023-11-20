import 'package:flutter/material.dart';
import 'historial_detail_page.dart';
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
  // int currentPage = 1;
  // int itemsPerPage = 2;

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
                if (isDataVisible && productosUsuario.isEmpty && mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('No registra compras'),
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
                padding: EdgeInsets.all(10),
                itemCount: productosUsuario.length,
                itemBuilder: (context, index) {
                  return Container(
                  margin: EdgeInsets.all(10),
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[300],
                  ),
                  child: ListTile(
                      title: Text('${producto[index]['nombre']}\n'),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Text('ID Producto: ${producto[index]['id']}\n'),
                            Text(
                                'Descripción: ${producto[index]['descripcion']}\n'),
                            Text(
                                'Precio unitario: \$${producto[index]['precio']}\n'),
                            Text(
                                'Cantidad: ${productosUsuario[index]['cantidad']}\n'),
                            Text(
                                'Precio total: \$${producto[index]['total']}\n'),*/
                            Text(
                                'Fecha de compra: ${DateFormat(productosUsuario[index]['fecha'].toString()).format(DateTime.now()).substring(0, 19)}\n'),
                          ]),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistorialDetailPage(
                          nombre: '${producto[index]['nombre']}',
                          id: '${producto[index]['id']}',
                          descripcion: '${producto[index]['descripcion']}',
                          precio: '${producto[index]['precio']}',
                          cantidad: '${productosUsuario[index]['cantidad']}',
                          total: '${producto[index]['total']}',
                          fecha: '${DateFormat(productosUsuario[index]['fecha'].toString()).format(DateTime.now()).substring(0, 19)}',)),
                      );
                      },
                        ));
                },
              ),
            ),
          ),
          // Visibility(
          //   visible: isDataVisible,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {
          //           if (currentPage > 1) {
          //             setState(() {
          //               currentPage--;
          //               print(currentPage);
          //               fetchPurchaseHistory();
          //             });
          //           }
          //         },
          //         child: Text('Página Anterior'),
          //       ),
          //       const SizedBox(width: 10.0),
          //       ElevatedButton(
          //         onPressed: () {
          //           setState(() {
          //             currentPage++;
          //             print(currentPage);
          //             fetchPurchaseHistory();
          //           });
          //         },
          //         child: Text('Página Siguiente'),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Future<void> fetchPurchaseHistory() async {
    final conn = await getConnection();

    var result = await conn.query(
        // 'SELECT idProducto, cantidad, fecha FROM listaproductousuario WHERE idUsuario = ? LIMIT ? OFFSET ?',
        // [widget.idUsuario, itemsPerPage, (currentPage - 1) * itemsPerPage]);
        'SELECT idProducto, cantidad, fecha FROM listaproductousuario WHERE idUsuario = ?',
        [widget.idUsuario]);
    // print(result);
    productosUsuario = result.map((r) => r.fields).toList();
    // print(productosUsuario.length);
    dynamic result2;

    for (var i = 0; i < productosUsuario.length; i++) {
      result2 = await conn.query(
          'SELECT nombre, id, descripcion, precio FROM productoOld WHERE id = ?',
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
