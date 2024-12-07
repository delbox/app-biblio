import 'package:tracking_app/models/models.dart';

class Usuario {
  int id;
  String nombre;
  String apellido;
  String usuario;
  String? tipo;
  String? password;
  String? rol;
  List<Almacenes>? almacenes;
  List<Authority>? authorities;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.usuario,
    this.tipo = "",
    this.password = "",
    this.rol = "",
    this.almacenes = const [],
    this.authorities = const [],
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"] ?? 0,
        nombre: json["nombre"] ?? "",
        apellido: json["apellido"] ?? "",
        usuario: json["usuario"] ?? "",
        tipo: json["tipo"] ?? "",
        password: json["password"] ?? "",
        rol: json["rol"] ?? "",
        almacenes: json["almacenes"] == null
            ? []
            : List<Almacenes>.from(
                json["almacenes"].map((x) => Almacenes.fromJson(x))),
        authorities: json["authorities"] == null
            ? []
            : List<Authority>.from(
                json["authorities"].map((x) => Authority.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "usuario": usuario,
        "tipo": tipo ?? "",
        "password": password ?? "",
        "rol": rol ?? "",
        "almacenes": almacenes?.map((x) => x.toJson()).toList() ?? [],
        "authorities": authorities?.map((x) => x.toJson()).toList() ?? [],
      };

  Map<String, dynamic> toJsonChofer() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "usuario": usuario,
      };
}

class Authority {
  String authority;
  Authority({
    required this.authority,
  });
  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        authority: json["authority"],
      );
  Map<String, dynamic> toJson() => {
        "authority": authority,
      };
}
