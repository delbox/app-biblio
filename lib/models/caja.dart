class Caja {
  int id;
  String? codigo;
  String? numeroActivoFijo;
  String? subNumeroActivoFijo;
  String? descripcion;
  int? cajaViajeId;
  DateTime? fechaCreacion;

  Caja({
    required this.id,
    this.codigo,
    this.numeroActivoFijo,
    this.subNumeroActivoFijo,
    this.descripcion,
    this.cajaViajeId,
    this.fechaCreacion,
  });

  factory Caja.fromJson(Map<String, dynamic> json) => Caja(
        id: json["id"],
        codigo: json["codigo"],
        numeroActivoFijo: json["numeroActivoFijo"],
        subNumeroActivoFijo: json["subNumeroActivoFijo"],
        descripcion: json["descripcion"],
        cajaViajeId: json["cajaViajeId"],
        fechaCreacion: json["fechaCreacion"] == null ? null :DateTime.parse(json["fechaCreacion"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "numeroActivoFijo": numeroActivoFijo,
        "subNumeroActivoFijo": subNumeroActivoFijo,
        "descripcion": descripcion,
      };
}
