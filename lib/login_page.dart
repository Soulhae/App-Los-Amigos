import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mysql1/mysql1.dart';
import 'bienvenido_page.dart';
import 'home_page.dart';
import 'db_connection.dart';
import 'api/firebase_api.dart';
//import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, dynamic>> usuarios = [];
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
              Colors.blue.shade400
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInLeft(
                    duration: Duration(milliseconds: 2000),
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      )
                    ),
                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Inicio de sesión", style: TextStyle(color: Colors.white, fontSize: 40),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(9, 13, 228, 0.29),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  controller: userController,
                                  decoration: InputDecoration(
                                    hintText: "Usuario",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Contraseña",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1500), child: Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.grey),)),
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
                          onPressed: () => loginUsuario(context),
                          height: 50,
                          color: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),
                          child: Center(
                            child: Text("Continuar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      ],
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );

      /*appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 20.0),
            Row(children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () => loginUsuario(context),
                  child: const Text('Iniciar Sesión'),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a la página de registro al hacer clic en el botón
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text('Crear una cuenta'),
                ),
              ),
            ]),
            const SizedBox(height: 10.0),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),*/
  }

  // Future<void> fetchUsuarios() async {
  //   final conn = await getConnection();

  //   Results result = await conn.query('SELECT * FROM usuario');
  //   usuarios = result.map((r) => r.fields).toList();

  //   setState(() {});

  //   await conn.close();
  // }

  Future<Results> verificarCuenta(nombreUsuario, contrasena) async {
    final conn = await getConnection();

    Results result = await conn.query(
        'SELECT id FROM usuario WHERE nombre = ? AND password = ? ',
        [nombreUsuario, contrasena]);

     setState(() {});

    await conn.close();
    return result;
  }

  Future<void> loginUsuario(BuildContext context) async {
    String nombreUsuario = userController.text;
    String contrasena = passwordController.text;
    Results usuario = await verificarCuenta(nombreUsuario, contrasena);

    if (usuario.isNotEmpty) {
      int idUsuario = usuario.first['id'];
      // print('existe');
      // print('${usuario.first['id']}');
      setState(() {
        errorMessage = '';
      });
      if (context.mounted) {
        FirebaseApi().sendNotification(
          idUsuario: idUsuario,
          nombreUsuario: nombreUsuario,
          context: context,
        );
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BienvenidoPage(
                  idUsuario: idUsuario, nombreUsuario: nombreUsuario)),
        );
      }
    } else {
      if (nombreUsuario.isEmpty || contrasena.isEmpty) {
        // print('test');
        setState(() {
          errorMessage = 'Por favor, complete todos los campos.';
        });
        Future.delayed(const Duration(seconds: 5)).then((value) {
          setState(() {
            errorMessage = '';
          });
        });
        return;
      }
      // print('no existe');

      setState(() {
        errorMessage = 'Usuario ingresado no se encuentra registrado.';
        Future.delayed(const Duration(seconds: 5)).then((value) {
          setState(() {
            errorMessage = '';
          });
        });
      });
    }
  }
}