import 'dart:convert';

import 'package:tracking_app/models/models.dart';

SincronizacionCajaResponse sincronizacionCajaResponseFromJson(String str) =>
    SincronizacionCajaResponse.fromJson(json.decode(str));

String sincronizacionCajaResponseToJson(SincronizacionCajaResponse data) =>
    json.encode(data.toJson());

class SincronizacionCajaResponse {
  String mensaje;
  bool error;
  DataSincronizacionCaja data;

  SincronizacionCajaResponse({
    required this.mensaje,
    required this.error,
    required this.data,
  });

  factory SincronizacionCajaResponse.fromJson(Map<String, dynamic> json) =>
      SincronizacionCajaResponse(
        mensaje: json["mensaje"],
        error: json["error"],
        data: DataSincronizacionCaja.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
        "data": data.toJson(),
      };
}

class DataSincronizacionCaja {
  int ultimaFecha;
  List<Caja> registros;

  DataSincronizacionCaja({
    required this.ultimaFecha,
    required this.registros,
  });

  factory DataSincronizacionCaja.fromJson(Map<String, dynamic> json) =>
      DataSincronizacionCaja(
        ultimaFecha: json["ultimaFecha"],
        registros:
            List<Caja>.from(json["registros"].map((x) => Caja.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ultimaFecha": ultimaFecha,
        "registros": List<dynamic>.from(registros.map((x) => x.toJson())),
      };
}
