import 'package:sqflite/sqflite.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class ViajeCajaDb {
  Future<List<ViajeCaja>> obtenerDatos() async {
    var db = await DatabaseHelper().db();
    var results = await db.query("viaje_caja");

    List<ViajeCaja> list = results.isNotEmpty
        ? results.map((e) => ViajeCaja.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<Caja>> obtenerPorViaje(int? viajeId) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
        "SELECT c.*, vc.id as cajaViajeId "
        "FROM viaje_caja vc "
        "join caja c on c.id = vc.cajaId "
        "where (vc.viajeTmpId is null and vc.viajeId = ?) "
        "or (vc.viajeTmpId is not null and vc.viajeTmpId = ?)",
        [viajeId, viajeId]);

    List<Caja> list =
        results.isNotEmpty ? results.map((e) => Caja.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<Caja>> obtenerCajasDeViaje(int? viajeId) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
        "SELECT c.*, vc.id as cajaViajeId "
        "FROM viaje_caja vc "
        "join caja c on c.id = vc.cajaId "
        "where vc.viajeId = ?",
        [viajeId]);

    List<Caja> list =
        results.isNotEmpty ? results.map((e) => Caja.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<Map<String, dynamic>>> obtenerPorViajeIdMap(int? viajeId) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
        "SELECT vc.cajaId as id "
        "FROM viaje_caja vc "
        "join caja c on c.id = vc.cajaId "
        "where vc.viajeTmpId  = ?",
        [viajeId]);

    return results;
  }

  Future<List<Map<String, dynamic>>> obtenerPorViajeIdEntidadMap(
      int? viajeId) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
        "SELECT vc.cajaId as id "
        "FROM viaje_caja vc "
        "join caja c on c.id = vc.cajaId "
        "where  vc.viajeId = ?",
        [viajeId]);

    return results;
  }

  Future<int> obtenerCantidad() async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery('SELECT COUNT(*) FROM viaje_caja');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> insertar(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert(
      "viaje_caja",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> actualizar(int id, Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.update(
      "viaje_caja",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> eliminar(int? id) async {
    var db = await DatabaseHelper().db();
    return await db.delete(
      "viaje_caja",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> eliminarCajasViaje(String campo, int? idViaje) async {
    var db = await DatabaseHelper().db();
    return await db.delete(
      "viaje_caja",
      where: '$campo = ?',
      whereArgs: [idViaje],
    );
  }

  Future<void> delete(int viajeId) async {
    var db = await DatabaseHelper().db();
    await db.delete(
      "viaje_caja",
      where: 'viajeId = ?',
      whereArgs: [viajeId],
    );
  }

  Future<void> eliminarTodos() async {
    var db = await DatabaseHelper().db();
    await db.delete("viaje_caja");
  }
}
