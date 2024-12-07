import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tracking_app/models/models.dart';

class UsuarioDb {
  final String baseUrl = 'https://unabiblio2.up.railway.app';

  Future<Map<String, dynamic>> login(String usuario, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'usuario': usuario,
          'password': password
        })
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return {
          'usuario': Usuario.fromJson(data['usuario']),
          'mensaje': data['mensaje'],
          'token': data['token']
        };
      } else {
        throw Exception('Error al iniciar sesión');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Usuario?> obtenerPorId(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/usuarios/$id'),
        headers: {'Content-Type': 'application/json'}
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Usuario.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener usuario: $e');
    }
  }

  Future<List<Usuario>> obtenerDatos(int offset, int limit, String nombre) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/usuarios?offset=$offset&limit=$limit&nombre=$nombre'),
        headers: {'Content-Type': 'application/json'}
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Usuario.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Error al obtener usuarios: $e');
    }
  }
}
