import 'package:flutter/material.dart';
import 'package:soy_ese/home_page.dart';
import 'notifiers.dart';
import 'db_connection.dart';

class PerfilPage extends StatefulWidget{
  final int idUsuario;

  const PerfilPage({super.key, required this.idUsuario});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        children: [
          SizedBox(height:10),
          CircleAvatar(
            backgroundImage: AssetImage("assets/amigos.png",),
            radius: 80,
            backgroundColor: Colors.blue[100],
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("user")
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("user@mail.com")
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.all(50),
            child: MaterialButton(
              onPressed: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              height: 60,
              minWidth: MediaQuery.of(context).size.width,
              color: Colors.red[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.logout_outlined),
                  Text(
                    "Cerrar Sesión",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ]
              ))
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          isDarkModeNotifier.value = !isDarkModeNotifier.value;
        },
        child: const Icon(Icons.dark_mode),
      ),
    );
  }
} 