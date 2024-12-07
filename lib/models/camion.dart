import 'package:tracking_app/models/models.dart';

class Camion {
  int id;
  String chapa;
  String? descripcion;
  Usuario? chofer;
  int? choferId;
  String? choferNombre;

  Camion({
    required this.id,
    required this.chapa,
    this.descripcion,
    this.chofer,
    this.choferId,
    this.choferNombre,
  });

  factory Camion.fromJson(Map<String, dynamic> json) => Camion(
        id: json["id"],
        chapa: json["chapa"],
        descripcion: json["descripcion"],
        chofer:
            json["chofer"] != null ? Usuario.fromJson(json["chofer"]) : null,
        choferId: json["choferId"],
        choferNombre: json["choferNombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapa": chapa,
        "descripcion": descripcion,
        "choferId": chofer!.id,
        "choferNombre": "${chofer!.nombre} ${chofer!.apellido}",
      };
}
