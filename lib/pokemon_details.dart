import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonDetails extends StatefulWidget {
  final String pokemonName;
  final String pokemonImage;
  final String pokemonUrl; // URL del Pokémon

  const PokemonDetails({
    required this.pokemonName,
    required this.pokemonImage,
    required this.pokemonUrl,
  });

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  List<dynamic> _pokemonStats = []; // Lista para almacenar las estadísticas
  bool _isLoading = true;

  // Función para obtener las estadísticas del Pokémon
  Future<void> _fetchPokemonStats() async {
    final response = await http
        .get(Uri.parse(widget.pokemonUrl)); // Usamos la URL que recibimos

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _pokemonStats = data['stats']; // Guardamos las estadísticas
        _isLoading = false;
      });
    } else {
      throw Exception('Error al cargar las estadísticas del Pokémon');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPokemonStats(); // Cargamos las estadísticas cuando se inicia la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemonName),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding general
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen del Pokémon
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.pokemonImage,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),

              // Nombre del Pokémon
              Text(
                widget.pokemonName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),

              // Indicador de carga o estadísticas
              _isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Estadísticas:',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Mostrar las estadísticas dentro de Cards
                          for (var stat in _pokemonStats)
                            Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      stat['stat']['name'].toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${stat['base_stat']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
