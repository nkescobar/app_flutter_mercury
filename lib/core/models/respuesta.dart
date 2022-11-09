import 'dart:convert';

class Respuesta {
  dynamic respuesta;
  dynamic mensaje;

  Respuesta({
    this.respuesta,
    this.mensaje,
  });
  Map<String, dynamic> toMap() {
    return {
      'respuesta': respuesta,
      'mensaje': mensaje,
    };
  }

  factory Respuesta.fromMap(Map<String, dynamic> map) {
    return Respuesta(
      respuesta: map['respuesta'],
      mensaje: map['mensaje'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Respuesta.fromJson(String source) =>
      Respuesta.fromMap(json.decode(source));
}
