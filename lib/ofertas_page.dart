import 'package:flutter/material.dart';
import 'db_connection.dart';
import 'package:intl/intl.dart';

class OfertasPage extends StatefulWidget {
  final int idUsuario;

  const OfertasPage({super.key, required this.idUsuario});

  @override
  _OfertasPageState createState() => _OfertasPageState();
}

class _OfertasPageState extends State<OfertasPage> {
  bool isDataVisible = true;
  List<Map<String, dynamic>> ofertasUsuario = [];
  List<Map<String, dynamic>> oferta = [];

  @override
  void initState(){
    super.initState();
    fetchPurchaseHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas activas'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Visibility(
            visible: isDataVisible,
            child: Expanded(
              child: ListView.builder(
                itemCount: ofertasUsuario.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[300],
                    ),
                    child: ListTile(
                      title: Text('Oferta!! ${oferta[index]['nombre']} ${ofertasUsuario[index]['cantidadProd']} unidades con un ${ofertasUsuario[index]['porcDescuento']}% de descuento\n'),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Límite de usos: ${ofertasUsuario[index]['limiteUsos']}\n'),
                            Text(
                                'Fecha límite para utilizar la promoción: ${DateFormat(ofertasUsuario[index]['fechaLimite'].toString()).format(DateTime.now()).substring(0, 10)}\n'),
                            Text(
                                'Precio normal: \$${oferta[index]['total']}    '),
                            Text(
                                'Precio con descuento: \$${oferta[index]['totalDesc']}\n'),
                          ])));
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
        'SELECT cantidadProd, fechaLimite, porcDescuento, limiteUsos, idProducto FROM oferta WHERE idUsuario = ?',
        [widget.idUsuario]);
    // print(result);
    ofertasUsuario = result.map((r) => r.fields).toList();
    // print(productosUsuario.length);
    dynamic result2;

    if(result.isEmpty){
      if(context.mounted){
        showNoOfertasDialog(context);
      }
      setState(() {
        isDataVisible = false;
      });
    }else{
      for (var i = 0; i < ofertasUsuario.length; i++) {
        result2 = await conn.query(
            'SELECT nombre, precio FROM productoOld WHERE id = ?',
            [ofertasUsuario[i]['idProducto']]);
        if (result2.isNotEmpty) {
          var productoInfo = result2.first;
          var total = productoInfo['precio'] * ofertasUsuario[i]['cantidadProd'];
          var totalDesc = total * ((100 - ofertasUsuario[i]['porcDescuento'])/100);
          // print(productoInfo['precio']);
          // print(ofertasUsuario[i]['cantidadProd']);
          // print(total);
          // print(ofertasUsuario[i]['porcDescuento']);
          // print(totalDesc);

          oferta.add({
            'nombre': productoInfo['nombre'],
            // 'precio': productoInfo['precio'],
            'total': total,
            'totalDesc': totalDesc.round(),
          });
        }
      }
    }

    setState(() {});

    await conn.close();
  }

  void showNoOfertasDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No hay ofertas registradas'),
          content: const Text('No se encontraron ofertas para mostrar.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void toggleDataVisibility() {
    setState(() {
      isDataVisible = !isDataVisible;
    });
  }
}