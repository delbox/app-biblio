import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/common/constantes.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class AuthProvider extends ChangeNotifier {
  AuthResponse? authResponse = AuthResponse(
    mensaje: "",
    error: false,
    usuario: null,
    token: "",
    );

  Usuario usuarioLogueado = Usuario(
    id: 0,
    nombre: "",
    apellido: "",
    usuario: "",
    tipo: "",
    password: "",
    rol: "",
    almacenes: [],
    authorities: [],
  );

  String almacenOrigen = "";

  login(AuthRequest data) async {
    try {
      final url = Uri.parse("$API_CONTEXT/auth/login");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        authResponse = AuthResponse.fromJson(decodedResponse);

        if (!authResponse!.error && authResponse != null) {
          final SharedPreferences preferences = await SharedPreferences.getInstance();

          await preferences.setString(
            "app-tracking-token", 
            authResponse!.token!
          );

          await preferences.setString(
            "app-tracking-usuario", 
            jsonEncode(authResponse!.usuario.toString())
          );

          for (var element in authResponse!.usuario!.almacenes!) {
            await AlmacenDb().insertarAlmacenLogin(element.almacen.toJson());
          }

          usuarioLogueado = authResponse!.usuario!;
        }
      } else {
        authResponse = AuthResponse(
          mensaje: "Credenciales Incorrectas",
          error: true,
          usuario: null,
        );
      }

      notifyListeners();
    } catch (e) {
      authResponse = AuthResponse(
        mensaje: e.toString(),
        error: true,
        usuario: null,
      );
      notifyListeners();
    }
  }

  setUsuarioLogueado() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final usuarioString = preferences.getString("app-tracking-usuario");

    if (usuarioString != null && usuarioString != "null") {
      try {
        final Map<String, dynamic> usuarioJson = jsonDecode(usuarioString);
        usuarioLogueado = Usuario.fromJson(usuarioJson);
        print('Rol del usuario: ${usuarioLogueado.rol}');
      } catch (e) {
        print('Error al decodificar usuario: $e');
      }
    }

    notifyListeners();
  }

  Future<List<Almacenes>> obtenerAlmacenesUsuarioLogueado(
      String descripcion) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final usuarioString = preferences.getString("app-tracking-usuario");

    if (usuarioString != null && usuarioString != "null") {
      try {
        final Map<String, dynamic> usuarioJson = jsonDecode(usuarioString);
        usuarioLogueado = Usuario.fromJson(usuarioJson);
        return usuarioLogueado.almacenes ?? [];
      } catch (e) {
        print('Error al decodificar usuario: $e');
        return [];
      }
    }

    return [];
  }

  setAlmacenOrigen(String? almacen) {
    almacenOrigen = almacen ?? "";
    notifyListeners();
  }

  Future<bool> checkLoginStatus() async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final usuarioString = preferences.getString("app-tracking-usuario");
      
      if (usuarioString != null && usuarioString != "null") {
        final Map<String, dynamic> usuarioJson = jsonDecode(usuarioString);
        usuarioLogueado = Usuario.fromJson(usuarioJson);
        return true;
      }
      return false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }
}
