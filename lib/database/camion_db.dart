import 'package:sqflite/sqflite.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class CamionDB {
  Future<List<Camion>> obtenerDatos(
      int offset, int limit, String descripcion) async {
    var db = await DatabaseHelper().db();
    var results = await db.query(
      "camion",
      where: descripcion.isNotEmpty ? 'UPPER(descripcion) LIKE ?' : null,
      whereArgs:
          descripcion.isNotEmpty ? ["%${descripcion.toUpperCase()}%"] : null,
      offset: offset,
      limit: limit,
    );

    List<Camion> list = results.isNotEmpty
        ? results.map((e) => Camion.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<Camion?> obtenerPorId(int id) async {
    var db = await DatabaseHelper().db();
    final results =
        await db.rawQuery('SELECT * FROM camion where id = ?', [id]);

    List<Camion> list = results.isNotEmpty
        ? results.map((e) => Camion.fromJson(e)).toList()
        : [];
    return list.isEmpty ? null : list[0];
  }

  Future<int> obtenerCantidad() async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery('SELECT COUNT(*) FROM camion');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> insertar(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert(
      "camion",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertarCamionLogin(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert(
      "camion_login",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> actualizar(int id, Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.update(
      "camion",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
