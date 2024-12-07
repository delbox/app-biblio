// To parse this JSON data, do
//
//     final sincronizacionAlmacenResponse = sincronizacionAlmacenResponseFromJson(jsonString);

import 'dart:convert';

import 'package:tracking_app/models/models.dart';

SincronizacionAlmacenResponse sincronizacionAlmacenResponseFromJson(
        String str) =>
    SincronizacionAlmacenResponse.fromJson(json.decode(str));

String sincronizacionAlmacenResponseToJson(
        SincronizacionAlmacenResponse data) =>
    json.encode(data.toJson());

class SincronizacionAlmacenResponse {
  String mensaje;
  bool error;
  DataSincronizacionAlmacenResponse data;

  SincronizacionAlmacenResponse({
    required this.mensaje,
    required this.error,
    required this.data,
  });

  factory SincronizacionAlmacenResponse.fromJson(Map<String, dynamic> json) =>
      SincronizacionAlmacenResponse(
        mensaje: json["mensaje"],
        error: json["error"],
        data: DataSincronizacionAlmacenResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
        "data": data.toJson(),
      };
}

class DataSincronizacionAlmacenResponse {
  int ultimaFecha;
  List<Almacen> registros;

  DataSincronizacionAlmacenResponse({
    required this.ultimaFecha,
    required this.registros,
  });

  factory DataSincronizacionAlmacenResponse.fromJson(
          Map<String, dynamic> json) =>
      DataSincronizacionAlmacenResponse(
        ultimaFecha: json["ultimaFecha"],
        registros: List<Almacen>.from(
            json["registros"].map((x) => Almacen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ultimaFecha": ultimaFecha,
        "registros": List<dynamic>.from(registros.map((x) => x.toJson())),
      };
}
