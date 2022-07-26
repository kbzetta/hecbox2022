class Operacion {
  final String fecha_programada_operacion;
  final String quirofano_reservado;
  final String quirofano_real;
  final String fecha_original_operacion;
  final String procedimiento_tipo;
  final String id_operacion;
  Paciente paciente;

  Operacion({
    required this.fecha_programada_operacion,
    required this.quirofano_reservado,
    required this.fecha_original_operacion,
    required this.id_operacion,
    required this.procedimiento_tipo,
    required this.quirofano_real,
    required this.paciente,
  });

  factory Operacion.fromJson(Map<String, dynamic> json) {
    return Operacion(
      fecha_programada_operacion: json['fecha_programada_operacion'],
      quirofano_reservado: json['quirofano_reservado'],
      fecha_original_operacion: json['fecha_original_operacion'],
      id_operacion: json['id_operacion'],
      procedimiento_tipo: json['procedimiento_tipo'] ?? '',
      quirofano_real: json['quirofano_real'],
      paciente: Paciente.fromJson(json["paciente"]),
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class Paciente {
  final String nombre;
  final String apellido;
  final String id_paciente;
  final String sexo;
  final String historia_clinica;
  final String dni;
  final String edad;

  Paciente(
      {required this.nombre,
      required this.apellido,
      required this.id_paciente,
      required this.dni,
      required this.historia_clinica,
      required this.sexo,
      required this.edad});

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      nombre: json['nombre'],
      dni: json['dni'],
      edad: json['edad'],
      sexo: json['sexo'],
      historia_clinica: json['historia_clinica'],
      apellido: json['apellido'],
      id_paciente: json['id_paciente'],
    );
  }
}
