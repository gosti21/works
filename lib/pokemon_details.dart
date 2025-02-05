import 'package:flutter/material.dart';

class PokemonDetails extends StatelessWidget {
  final String pokemonName;
  final String pokemonImage;

  // Recibimos el nombre y la imagen del Pokémon como parámetros
  const PokemonDetails({required this.pokemonName, required this.pokemonImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonName),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemonImage), // Mostramos la imagen del Pokémon
            SizedBox(height: 20),
            Text(
              pokemonName,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Aquí puedes agregar más información estática o dinámica sobre el Pokémon
          ],
        ),
      ),
    );
  }
}
