class ViajeCajaRecibir {
  int? id;
  int? viajeId;
  int? cajaId;
  String? descripcion;
  String? codigo;
  DateTime? fechaCreacion;

  ViajeCajaRecibir(
      {this.id,
      this.viajeId,
      this.cajaId,
      this.descripcion,
      this.codigo,
      this.fechaCreacion});

  factory ViajeCajaRecibir.fromJson(Map<String, dynamic> json) =>
      ViajeCajaRecibir(
        id: json["id"],
        viajeId: json["viajeId"],
        cajaId: json["cajaId"],
        descripcion: json["descripcion"],
        codigo: json["codigo"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
      );

  Map<String, dynamic> toJson() => {
        "viajeId": viajeId,
        "cajaId": cajaId,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
      };
}

class ViajeFinalizarRequest {
  List<Map<String, dynamic>> cajas;

  ViajeFinalizarRequest({
    required this.cajas,
  });

  factory ViajeFinalizarRequest.fromJson(Map<String, dynamic> json) =>
      ViajeFinalizarRequest(
        cajas: [],
      );

  Map<String, dynamic> toJson() => {
        "cajas": List<Map<String, dynamic>>.from(cajas.map((x) => x)),
      };
}

class ViajeFinalizarResponse {
  String mensaje;
  bool error;

  ViajeFinalizarResponse({
    required this.mensaje,
    required this.error,
  });

  factory ViajeFinalizarResponse.fromJson(Map<String, dynamic> json) =>
      ViajeFinalizarResponse(
        mensaje: json["mensaje"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
      };
}
