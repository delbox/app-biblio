import 'package:flutter/material.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class AlmacenProvider extends ChangeNotifier {
  Future<List<Almacen>> obtenerDatos(String descripcion) async {
    final registros = AlmacenDb().obtenerDatos(0, 20, descripcion);

    return registros;
  }
}
