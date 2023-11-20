import 'package:flutter/material.dart';

class HistorialDetailPage extends StatefulWidget{
  final String nombre;
  final String id;
  final String descripcion;
  final String precio;
  final String cantidad;
  final String total;
  final String fecha;

  const HistorialDetailPage({super.key,
  required this.nombre,
  required this.id,
  required this.descripcion,
  required this.precio,
  required this.cantidad,
  required this.total,
  required this.fecha,});

  @override
  _HistorialDetailPageState createState() => _HistorialDetailPageState();
}

class _HistorialDetailPageState extends State<HistorialDetailPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información producto'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
          SizedBox(height:10),
          CircleAvatar(
            backgroundImage: AssetImage("assets/estrella.png"),
            radius: 100,
            backgroundColor: Colors.blue[100],
          ),
          Text('${widget.nombre}',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          Text('Id: ${widget.id}'),
          SizedBox(height:10),
          Text(widget.descripcion),
          SizedBox(height:10),
          ListTile(
            leading: Icon(Icons.attach_money_rounded),
            title: Text('Precio: \$${widget.precio}'),
          ),
          ListTile(
            leading: Icon(Icons.numbers),
            title: Text('Cantidad: ${widget.cantidad}'),
          ),
          ListTile(
            leading: Icon(Icons.attach_money_rounded),
            title: Text('Total: \$${widget.total}'),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month_rounded),
            title: Text('Fecha: ${widget.fecha}'),
          ),
          
        ],
      ),
        )
    );
  }
}