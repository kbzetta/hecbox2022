import 'dart:convert';

List<NombreModel> coberturaFromJson(String str) =>
    List<NombreModel>.from(json.decode(str).map((x) => NombreModel.fromMap(x)));

class NombreModel {
  NombreModel({
    required this.nombre,
  });

  String nombre;

  factory NombreModel.fromMap(Map<String, dynamic> json) => NombreModel(
        nombre: json["nombre"] as String,
      );
}
