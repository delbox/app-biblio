// To parse this JSON data, do
//
//     final sincronizacion = sincronizacionFromJson(jsonString);

import 'dart:convert';

Sincronizacion sincronizacionFromJson(String str) =>
    Sincronizacion.fromJson(json.decode(str));

String sincronizacionToJson(Sincronizacion data) => json.encode(data.toJson());

class Sincronizacion {
  int id;
  String tabla;
  int fechaUltimaSincronizacion;

  Sincronizacion({
    required this.id,
    required this.tabla,
    required this.fechaUltimaSincronizacion,
  });

  factory Sincronizacion.fromJson(Map<String, dynamic> json) => Sincronizacion(
        id: json["id"],
        tabla: json["tabla"],
        fechaUltimaSincronizacion: json["fechaUltimaSincronizacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tabla": tabla,
        "fechaUltimaSincronizacion": fechaUltimaSincronizacion,
      };
}
