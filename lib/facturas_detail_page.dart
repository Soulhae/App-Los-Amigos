import 'package:flutter/material.dart';

class FacturasDetailPage extends StatefulWidget{
  final String id;
  final String fecha;
  final String nombreProducto;
  final String precio;
  final String cantidad;
  final String total;
  final String fechaVencimiento;

  const FacturasDetailPage({super.key,
  required this.id,
  required this.fecha,
  required this.nombreProducto,
  required this.precio,
  required this.cantidad,
  required this.total,
  required this.fechaVencimiento,});

  @override
  _FacturasDetailPageState createState() => _FacturasDetailPageState();
}

class _FacturasDetailPageState extends State<FacturasDetailPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información factura'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
          SizedBox(height:10),
          CircleAvatar(
            backgroundImage: AssetImage("assets/factura.png"),
            radius: 100,
            backgroundColor: Colors.blue[100],
          ),
          Text('Factura ${widget.id}',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          Text('Fecha: ${widget.fecha}'),
          ListTile(
            title: Text(widget.nombreProducto),
          ),
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
            title: Text('Fecha de vencimiento: ${widget.fechaVencimiento}'),
          ),
          
        ],
      ),
        )
    );
  }
}