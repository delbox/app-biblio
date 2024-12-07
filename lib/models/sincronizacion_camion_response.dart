import 'dart:convert';

import 'package:tracking_app/models/models.dart';

SincronizacionCamionResponse sincronizacionCamionResponseFromJson(String str) =>
    SincronizacionCamionResponse.fromJson(json.decode(str));

String sincronizacionCamionResponseToJson(SincronizacionCamionResponse data) =>
    json.encode(data.toJson());

class SincronizacionCamionResponse {
  String mensaje;
  bool error;
  DataSincronizacionCamionResponse data;

  SincronizacionCamionResponse({
    required this.mensaje,
    required this.error,
    required this.data,
  });

  factory SincronizacionCamionResponse.fromJson(Map<String, dynamic> json) =>
      SincronizacionCamionResponse(
        mensaje: json["mensaje"],
        error: json["error"],
        data: DataSincronizacionCamionResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
        "data": data.toJson(),
      };
}

class DataSincronizacionCamionResponse {
  int ultimaFecha;
  List<Camion> registros;

  DataSincronizacionCamionResponse({
    required this.ultimaFecha,
    required this.registros,
  });

  factory DataSincronizacionCamionResponse.fromJson(
          Map<String, dynamic> json) =>
      DataSincronizacionCamionResponse(
        ultimaFecha: json["ultimaFecha"],
        registros:
            List<Camion>.from(json["registros"].map((x) => Camion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ultimaFecha": ultimaFecha,
        "registros": List<dynamic>.from(registros.map((x) => x.toJson())),
      };
}

class Chofer {
  int id;
  String nombre;
  String apellido;
  String usuario;
  String tipo;
  String rol;
  String estado;
  DateTime fechaCreacion;
  dynamic fechaModificacion;
  dynamic fechaEliminacion;
  List<dynamic> almacenes;

  Chofer({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.usuario,
    required this.tipo,
    required this.rol,
    required this.estado,
    required this.fechaCreacion,
    required this.fechaModificacion,
    required this.fechaEliminacion,
    required this.almacenes,
  });

  factory Chofer.fromJson(Map<String, dynamic> json) => Chofer(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        usuario: json["usuario"],
        tipo: json["tipo"],
        rol: json["rol"],
        estado: json["estado"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaModificacion: json["fechaModificacion"],
        fechaEliminacion: json["fechaEliminacion"],
        almacenes: List<dynamic>.from(json["almacenes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "usuario": usuario,
        "tipo": tipo,
        "rol": rol,
        "estado": estado,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaModificacion": fechaModificacion,
        "fechaEliminacion": fechaEliminacion,
        "almacenes": List<dynamic>.from(almacenes.map((x) => x)),
      };
}
