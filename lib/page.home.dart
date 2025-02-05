import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Clase para representar cada Pokémon
class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  // Crear una lista de Pokémons a partir de la respuesta de la API
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
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
                  CircularProgressIndicator()) // Muestra un indicador de carga mientras obtenemos los datos
          : ListView.builder(
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = _pokemons[index];
                return ListTile(
                  title: Text(pokemon.name),
                  onTap: () {
                    // Aquí se puede navegar a la página de detalles del Pokémon
                  },
                );
              },
            ),
    );
  }
}
