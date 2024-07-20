import 'package:flutter/material.dart';
import 'package:recetariopersonal/databases/database.dart';
import 'package:recetariopersonal/pantallas/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  String _error = '';

  void _iniciarSesion() async {
    String correo = _correoController.text.trim();
    String contrasena = _contrasenaController.text;

    var usuario = await _databaseHelper.obtenerUsuario(correo, contrasena);

    if (usuario != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(usuarioId: usuario['id'])),
      );
    } else {
      setState(() {
        _error = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
              decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Imagenes/login.jpg'),
                fit: BoxFit.cover
                ),
              ),
              child: Center(
                child:Padding(
                  padding: EdgeInsets.all(16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:30),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 153, 221),
                          borderRadius: BorderRadius.circular(10),
                        ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                icon: Icon(Icons.person),
                errorText: _error.isNotEmpty ? _error : null,
              ),
            ),
            SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 153, 221),
                ),
              ),
              ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contrasenaController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _iniciarSesion,
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/registro'); // Navega a la pantalla de registro
              },
              child: Text('Crear una cuenta'),
            ),
          ],
        ),
      ),
    ]),),),
    ),
    );
  }
}
