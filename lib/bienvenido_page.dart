import 'package:flutter/material.dart';
import 'facturas_page.dart';
import 'historial_page.dart';
import 'ofertas_page.dart';
import 'perfil_page.dart';

class BienvenidoPage extends StatelessWidget {
  final String nombreUsuario;
  final int idUsuario;

  const BienvenidoPage({
    super.key,
    required this.idUsuario,
    required this.nombreUsuario,
  });
  static const route = '/bienvenido-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Text("¡Bienvenido, $nombreUsuario!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ))),
          Container(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FacturasPage(idUsuario: idUsuario)),
                    );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 70,
                        color: Colors.blue[300],
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.blue[900],
                              width: 70,
                              height: 70,
                              child: Icon(Icons.checklist_sharp,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Facturas',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.blue[900]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HistorialPage(idUsuario: idUsuario)),
                    );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 70,
                        color: Colors.blue[300],
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.blue[900],
                              width: 70,
                              height: 70,
                              child: Icon(Icons.history_toggle_off,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Historial de compras',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.blue[900]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfertasPage(idUsuario: idUsuario,)),
                    );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 70,
                        color: Colors.blue[300],
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.blue[900],
                              width: 70,
                              height: 70,
                              child: Icon(Icons.discount_outlined,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Ofertas',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.blue[900]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PerfilPage(idUsuario: idUsuario)),
                    );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 70,
                        color: Colors.blue[300],
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.blue[900],
                              width: 70,
                              height: 70,
                              child: Icon(Icons.account_circle_rounded,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Perfil',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.blue[900]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ]))

        /*appBar: AppBar(title: const Text('Bienvenid@!'), actions: <Widget>[
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
                MaterialPageRoute(builder: (context) => const OfertasPage()));
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
      ),*/
        );
  }
}
