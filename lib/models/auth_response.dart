// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';
import 'package:tracking_app/models/models.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  String mensaje;
  bool error;
  Usuario? usuario;
  String? token;

  AuthResponse({
    this.mensaje = "",
    required this.error,
    this.usuario,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        mensaje: json["mensaje"] ?? "",
        error: json["error"] ?? true,
        usuario: json["usuario"] == null
            ? null
            : Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
        "usuario": usuario?.toJson(),
      };
}

