import 'package:sqflite/sqflite.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class CajaDb {
  Future<List<Caja>> obtenerDatos() async {
    var db = await DatabaseHelper().db();
    var results = await db.query("caja");

    List<Caja> list =
        results.isNotEmpty ? results.map((e) => Caja.fromJson(e)).toList() : [];
    return list;
  }

  Future<Caja> obtenerPorId(int id) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery('SELECT * FROM caja where id = ?', [id]);

    List<Caja> list =
        results.isNotEmpty ? results.map((e) => Caja.fromJson(e)).toList() : [];
    return list[0];
  }

  Future<Caja?> obtenerPorCodigo(String codigo) async {
    var db = await DatabaseHelper().db();
    final results =
        await db.rawQuery('SELECT * FROM caja where codigo = ?', [codigo]);

    List<Caja> list =
        results.isNotEmpty ? results.map((e) => Caja.fromJson(e)).toList() : [];
    return list.isEmpty ? null : list[0];
  }

  Future<int> obtenerCantidad() async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery('SELECT COUNT(*) FROM caja');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> insertar(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert(
      "caja",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> actualizar(int id, Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.update(
      "caja",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
