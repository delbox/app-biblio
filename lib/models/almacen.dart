class Almacen {
  int id;
  String descripcion;

  Almacen({
    required this.id,
    required this.descripcion,
  });

  factory Almacen.fromJson(Map<String, dynamic> json) => Almacen(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}

class Almacenes {
  int id;
  Almacen almacen;
  String estado;
  DateTime? fechaCreacion;
  dynamic fechaModificacion;
  dynamic fechaEliminacion;

  Almacenes({
    required this.id,
    required this.almacen,
    required this.estado,
    this.fechaCreacion,
    required this.fechaModificacion,
    required this.fechaEliminacion,
  });

  factory Almacenes.fromJson(Map<String, dynamic> json) => Almacenes(
        id: json["id"],
        almacen: Almacen.fromJson(json["almacen"]),
        estado: json["estado"],
        fechaCreacion: json["fechaCreacion"] == null
            ? null
            : DateTime.parse(json["fechaCreacion"]),
        fechaModificacion: json["fechaModificacion"],
        fechaEliminacion: json["fechaEliminacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "almacen": almacen.toJson(),
        "estado": estado,
        "fechaCreacion":
            fechaCreacion == null ? null : fechaCreacion!.toIso8601String(),
        "fechaModificacion": fechaModificacion,
        "fechaEliminacion": fechaEliminacion,
      };
}
