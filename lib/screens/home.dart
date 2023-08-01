import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // Ajusta el ancho al tamaño de la pantalla del smartwatch
          height: MediaQuery.of(context).size.height, // Ajusta la altura al tamaño de la pantalla del smartwatch
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Notificaciones Wear',
                style: TextStyle(fontSize: 24.0),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
