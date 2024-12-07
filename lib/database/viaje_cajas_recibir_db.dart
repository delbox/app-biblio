import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class ViajeCajasRecibirDB {
  Future<int> insertar(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert("viaje_caja_recepcion", row);
  }

  Future<int> eliminar(int? id) async {
    var db = await DatabaseHelper().db();
    return await db.delete(
      "viaje_caja_recepcion",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> eliminarPorViaje(int? viajeId) async {
    var db = await DatabaseHelper().db();
    return await db.delete(
      "viaje_caja_recepcion",
      where: 'viajeId = ?',
      whereArgs: [viajeId],
    );
  }

  Future<List<Map<String, dynamic>>> obtenerViajes() async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
      "select viajeId from viaje_caja_recepcion vcr group by viajeId",
    );

    return results;
  }

  Future<List<Map<String, dynamic>>> obtenerPorViajeMap(int? viajeId) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
        "SELECT cajaId as id FROM viaje_caja_recepcion where viajeId = ?",
        [viajeId]);

    return results;
  }

  Future<List<ViajeCajaRecibir>> obtenerCajasPorViaje(int? viajeId) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
        "SELECT * FROM viaje_caja_recepcion where viajeId = ?", [viajeId]);

    List<ViajeCajaRecibir> list = results.isNotEmpty
        ? results.map((e) => ViajeCajaRecibir.fromJson(e)).toList()
        : [];

    return list;
  }
}
