import 'package:flutter/material.dart';
import 'page_home.dart'; // Importa la página de inicio o la página de destino

void main() {
  runApp(const MyApp()); // Aquí está la función main que lanza la aplicación
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key})
      : super(key: key); // Asegúrate de que MyApp sea un StatelessWidget

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poke API',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema básico de color azul
      ),
      home: WelcomeScreen(), // Aquí especificas la pantalla principal
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estudiante: Zambrano Candiotti Sergio"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFF0000), // Rojo vivo de fondo
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // El icono ha sido eliminado
            SizedBox(height: 20),
            Text(
              'BIENVENIDO A LA POKE API',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a PageHome cuando se presiona el botón
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PageHome()), // Navegar a PageHome
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'CONTINUAR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
