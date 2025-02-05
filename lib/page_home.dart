import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon_details.dart'; // Importamos la pantalla de detalles

// Clase para representar cada Pokémon
class Pokemon {
  final String name;
  final String url;
  final String imageUrl;

  Pokemon({required this.name, required this.url, required this.imageUrl});

  // Obtener la ID del Pokémon a partir de la URL
  static String _extractId(String url) {
    final parts = url.split('/');
    return parts[parts.length - 2]; // Extrae el penúltimo segmento (la ID)
  }

  // Crear una lista de Pokémons a partir de la respuesta de la API
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final id = _extractId(json['url']);
    return Pokemon(
      name: json['name'],
      url: json['url'],
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png",
    );
  }
}

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  // Lista para almacenar los Pokémon
  List<Pokemon> _pokemons = [];

  @override
  void initState() {
    super.initState();
    _fetchPokemons(); // Llamamos a la función para obtener los pokémons al iniciar la pantalla
  }

  // Función para obtener los Pokémon desde la PokéAPI
  Future<void> _fetchPokemons() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, parseamos los datos
      final data = json.decode(response.body);
      final List<Pokemon> pokemons = [];
      for (var pokemon in data['results']) {
        pokemons.add(Pokemon.fromJson(pokemon));
      }

      setState(() {
        _pokemons = pokemons; // Actualizamos el estado para mostrar los Pokémon
      });
    } else {
      throw Exception('Error al cargar los Pokémon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Pokémons"),
        backgroundColor: Colors.red,
      ),
      body: _pokemons.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Muestra un indicador de carga
          : ListView.builder(
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = _pokemons[index];
                return ListTile(
                  leading: Image.network(pokemon.imageUrl), // Mostrar la imagen
                  title: Text(pokemon.name),
                  onTap: () {
                    // Navegar a la página de detalles, pasamos la URL del Pokémon
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetails(
                          pokemonName: pokemon.name,
                          pokemonImage: pokemon.imageUrl,
                          pokemonUrl: pokemon.url, // Pasamos la URL aquí
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
