import 'dart:convert';

AuthRequest authRequestFromJson(String str) =>
    AuthRequest.fromJson(json.decode(str));

String authRequestToJson(AuthRequest data) => json.encode(data.toJson());

class AuthRequest {
  String usuario;
  String password;
  String tipo;

  AuthRequest({
    required this.usuario,
    required this.password,
    required this.tipo,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) => AuthRequest(
        usuario: json["usuario"],
        password: json["password"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "password": password,
        "tipo": tipo,
      };
}
