import 'dart:convert';

import 'package:tracking_app/models/models.dart';

SincronizacionChoferResponse sincronizacionChoferResponseFromJson(String str) =>
    SincronizacionChoferResponse.fromJson(json.decode(str));

String sincronizacionChoferResponseToJson(SincronizacionChoferResponse data) =>
    json.encode(data.toJson());

class SincronizacionChoferResponse {
  String mensaje;
  bool error;
  Data data;

  SincronizacionChoferResponse({
    required this.mensaje,
    required this.error,
    required this.data,
  });

  factory SincronizacionChoferResponse.fromJson(Map<String, dynamic> json) =>
      SincronizacionChoferResponse(
        mensaje: json["mensaje"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
        "data": data.toJson(),
      };
}

class Data {
  int ultimaFecha;
  List<Usuario> registros;

  Data({
    required this.ultimaFecha,
    required this.registros,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ultimaFecha: json["ultimaFecha"],
        registros: List<Usuario>.from(
            json["registros"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ultimaFecha": ultimaFecha,
        "registros": List<dynamic>.from(registros.map((x) => x.toJson())),
      };
}
