import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hecbox/ConfigGenerales.dart';
import 'package:hecbox/Vistas/inicioVista.dart';

import '../Modelos/modelos.dart';
import 'package:http/http.dart' as http;

Future<List<Operacion>> buscarPaciente(String query) async {
  final response =
      await http.get(Uri.parse("$serverUrl/operacions/?id_operacion=$query"));

  return getOperacion(response.body);
}

List<Operacion> getOperacion(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Operacion>((json) => Operacion.fromJson(json)).toList();
}

Future<List<Operacion>> fetchOperacion(http.Client client) async {
  final response = await http.get(Uri.parse("$serverUrl/operacions"));

  return getOperacion(
    response.body,
  );
}

class DataSearch extends SearchDelegate {
  DataSearch({
    String hintText = "Ingresar ID Paciente",
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: const Text('paciente.id'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder<List<Operacion?>>(
      future: buscarPaciente(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<Operacion?>> snapshot) {
        if (snapshot.hasData) {
          final pacientes = snapshot.data;

          return ListView(
              children: pacientes!.map((paciente) {
            return ListTile(
              title: Text(paciente!.paciente.nombre),
              onTap: () {
                close(context, null);
                Get.to(InicioVista(paciente: paciente));
              },
            );
          }).toList());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
