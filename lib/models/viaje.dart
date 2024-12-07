import 'package:tracking_app/models/models.dart';

class Viaje {
  int? id;
  int? idEntidad;
  int? almacenOrigenId;
  int? almacenDestinoId;
  int? camionId;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  DateTime? fechaEliminacion;
  int? usuarioCreacion;
  int? usuarioModificacion;
  int? usuarioEliminacion;
  String? sincronizado;
  String? almacenDestino;
  String? direccion;
  String? almacenOrigen;
  String? chapa;
  int? cantidadCaja;
  int? choferId;
  String? chofer;
  String? estado;
  String? comentarioFin;

  Viaje({
    this.id,
    this.idEntidad,
    this.almacenOrigenId,
    this.almacenDestinoId,
    this.camionId,
    this.fechaCreacion,
    this.fechaModificacion,
    this.fechaEliminacion,
    this.usuarioCreacion,
    this.usuarioModificacion,
    this.usuarioEliminacion,
    this.sincronizado,
    this.almacenDestino,
    this.direccion,
    this.almacenOrigen,
    this.chapa,
    this.cantidadCaja,
    this.choferId,
    this.chofer,
    this.estado,
    this.comentarioFin,
  });

  factory Viaje.fromJson(Map<String, dynamic> json) => Viaje(
        id: json["id"],
        idEntidad: json["idEntidad"],
        almacenOrigenId: json["almacenOrigenId"],
        almacenDestinoId: json["almacenDestinoId"],
        camionId: json["camionId"],
        fechaCreacion: json["fechaCreacion"] == null
            ? null
            : DateTime.parse(json["fechaCreacion"]),
        fechaModificacion: json["fechaModificacion"] == null
            ? null
            : DateTime.parse(json["fechaModificacion"]),
        fechaEliminacion: json["fechaEliminacion"] == null
            ? null
            : DateTime.parse(json["fechaEliminacion"]),
        usuarioCreacion: json["usuarioCreacion"],
        usuarioModificacion: json["usuarioModificacion"],
        usuarioEliminacion: json["usuarioEliminacion"],
        sincronizado: json["sincronizado"],
        almacenDestino: json["almacenDestino"],
        direccion: json["direccion"],
        almacenOrigen: json["almacenOrigen"],
        chapa: json["chapa"],
        cantidadCaja: json["cantidadCaja"],
        choferId: json["choferId"],
        chofer: json["chofer"],
        estado: json["estado"],
        comentarioFin: json["comentarioFin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idEntidad": idEntidad,
        "almacenOrigenId": almacenOrigenId,
        "almacenDestinoId": almacenDestinoId,
        "camionId": camionId,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaModificacion": fechaModificacion?.toIso8601String(),
        "fechaEliminacion": fechaEliminacion?.toIso8601String(),
        "usuarioCreacion": usuarioCreacion,
        "usuarioModificacion": usuarioModificacion,
        "usuarioEliminacion": usuarioEliminacion,
        "sincronizado": sincronizado,
        "choferId": choferId,
        "estado": estado,
        "comentarioFin": comentarioFin
      };
}

class ViajeRequest {
  int? id;
  int? idEntidad;
  Map<String, dynamic> almacenDestino;
  Map<String, dynamic> almacenOrigen;
  Map<String, dynamic> camion;
  List<Map<String, dynamic>> cajas;
  DateTime? fechaCreacion;
  Map<String, dynamic> chofer;

  ViajeRequest({
    this.id,
    this.idEntidad,
    required this.almacenDestino,
    required this.almacenOrigen,
    required this.camion,
    required this.cajas,
    this.fechaCreacion,
    required this.chofer,
  });

  factory ViajeRequest.fromJson(Map<String, dynamic> json) => ViajeRequest(
        id: json["id"],
        idEntidad: json["idEntidad"],
        almacenDestino: {"id": json["almacenDestinoId"]},
        almacenOrigen: {"id": json["almacenOrigenId"]},
        camion: {"id": json["camionId"]},
        cajas: [],
        fechaCreacion: json["fechaCreacion"] == null
            ? null
            : DateTime.parse(json["fechaCreacion"]),
        chofer: {"id": json["choferId"]},
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idEntidad": idEntidad,
        "almacenDestino": almacenDestino,
        "almacenOrigen": almacenOrigen,
        "camion": camion,
        "cajas": List<Map<String, dynamic>>.from(cajas.map((x) => x)),
        "fechaCreacion":
            fechaCreacion == null ? null : fechaCreacion!.toIso8601String(),
        "chofer": chofer,
      };
}

class ViajeResponse {
  String mensaje;
  bool error;
  DataViajeResponse? data;

  ViajeResponse({
    required this.mensaje,
    required this.error,
    this.data,
  });

  factory ViajeResponse.fromJson(Map<String, dynamic> json) => ViajeResponse(
        mensaje: json["mensaje"],
        error: json["error"],
        data: json["data"] == null
            ? null
            : DataViajeResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
        "data": data == null ? null : data!.toJson(),
      };
}

class ViajeResponseSync {
  String mensaje;
  bool error;
  List<DataViajeResponse> data;

  ViajeResponseSync({
    required this.mensaje,
    required this.error,
    required this.data,
  });

  factory ViajeResponseSync.fromJson(Map<String, dynamic> json) =>
      ViajeResponseSync(
        mensaje: json["mensaje"],
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<DataViajeResponse>.from(
                json["data"].map((x) => DataViajeResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataViajeResponse {
  int id;
  Almacen almacenDestino;
  Almacen almacenOrigen;
  Camion camion;
  List<Caja> cajas;
  DateTime fechaCreacion;
  Usuario usuarioCreacion;
  Usuario chofer;
  String estado;

  DataViajeResponse({
    required this.id,
    required this.almacenDestino,
    required this.almacenOrigen,
    required this.camion,
    required this.cajas,
    required this.fechaCreacion,
    required this.usuarioCreacion,
    required this.chofer,
    required this.estado,
  });

  factory DataViajeResponse.fromJson(Map<String, dynamic> json) =>
      DataViajeResponse(
        id: json["id"],
        almacenDestino: Almacen.fromJson(json["almacenDestino"]),
        almacenOrigen: Almacen.fromJson(json["almacenOrigen"]),
        camion: Camion.fromJson(json["camion"]),
        cajas: List<Caja>.from(json["cajas"].map((x) => Caja.fromJson(x))),
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        usuarioCreacion: Usuario.fromJson(json["usuarioCreacion"]),
        chofer: Usuario.fromJson(json["chofer"]),
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "almacenDestino": almacenDestino,
        "almacenOrigen": almacenOrigen,
        "camion": camion,
        "cajas": List<dynamic>.from(cajas.map((x) => x)),
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "usuarioCreacion": usuarioCreacion,
        "chofer": chofer,
        "estado": estado,
      };
}
