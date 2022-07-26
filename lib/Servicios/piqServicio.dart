import 'dart:convert';

import 'package:hecbox/Modelos/piqModelos.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../ConfigGenerales.dart';

Future<List<NombreModel>> demo() async {
  final response = await http.get(Uri.parse("$serverUrl/anestesia-tipos"));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed
        .map<NombreModel>((json) => NombreModel.fromMap(json))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}
