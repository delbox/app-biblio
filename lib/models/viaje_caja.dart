class ViajeCaja {
  int? id;
  int? viajeTmpId;
  int? viajeId;
  int? cajaId;
  int? usuarioEnvio;
  DateTime? fechaEnvio;
  DateTime? fechaRecepcion;
  int? usuarioRecepcion;
  String? envio;
  String? recepcion;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  DateTime? fechaEliminacion;
  int? usuarioCreacion;
  int? usuarioModificacion;
  int? usuarioEliminacion;
  String? sincronizado;

  ViajeCaja({
    this.id,
    this.viajeTmpId,
    this.viajeId,
    this.cajaId,
    this.fechaEnvio,
    this.usuarioEnvio,
    this.fechaRecepcion,
    this.usuarioRecepcion,
    this.envio,
    this.recepcion,
    this.fechaCreacion,
    this.fechaModificacion,
    this.fechaEliminacion,
    this.usuarioCreacion,
    this.usuarioModificacion,
    this.usuarioEliminacion,
    this.sincronizado,
  });

  factory ViajeCaja.fromJson(Map<String, dynamic> json) => ViajeCaja(
        id: json["id"],
        viajeTmpId: json["viajeTmpId"],
        viajeId: json["viajeId"],
        cajaId: json["cajaId"],
        usuarioEnvio: json["usuarioEnvio"],
        fechaEnvio: DateTime.parse(json["fechaEnvio"]),
        fechaRecepcion: json["fechaRecepcion"] == null
            ? null
            : DateTime.parse(json["fechaRecepcion"]),
        usuarioRecepcion: json["usuarioRecepcion"],
        envio: json["envio"],
        recepcion: json["recepcion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "viajeTmpId": viajeTmpId,
        "viajeId": viajeId,
        "cajaId": cajaId,
        "usuarioEnvio": usuarioEnvio,
        "fechaEnvio": fechaEnvio?.toIso8601String(),
        "fechaRecepcion": fechaRecepcion?.toIso8601String(),
        "usuarioRecepcion": usuarioRecepcion,
        "envio": envio,
        "recepcion": recepcion,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaModificacion": fechaModificacion?.toIso8601String(),
        "fechaEliminacion": fechaEliminacion?.toIso8601String(),
        "usuarioCreacion": usuarioCreacion,
        "usuarioModificacion": usuarioModificacion,
        "usuarioEliminacion": usuarioEliminacion,
        "sincronizado": sincronizado,
      };
}
