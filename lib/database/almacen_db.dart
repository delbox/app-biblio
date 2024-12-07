import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class AlmacenDb {
  Future<List<Almacen>> obtenerDatos(
      int offset, int limit, String descripcion) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final int? origen = preferences.getInt("app-tracking-origen");

    var db = await DatabaseHelper().db();
    var results = await db.query(
      "almacen",
      where: descripcion.isNotEmpty
          ? 'UPPER(descripcion) LIKE ? and id not in(?)'
          : 'id not in(?)',
      whereArgs: descripcion.isNotEmpty
          ? ["%${descripcion.toUpperCase()}%", origen]
          : [origen],
      offset: offset,
      limit: limit,
    );

    List<Almacen> list = results.isNotEmpty
        ? results.map((e) => Almacen.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<Almacen>> obtenerDatosLogin(
      int offset, int limit, String descripcion) async {
    var db = await DatabaseHelper().db();
    var results = await db.query(
      "almacen_login",
      where: descripcion.isNotEmpty ? 'descripcion LIKE ?' : null,
      whereArgs: descripcion.isNotEmpty ? ["%$descripcion%"] : null,
      offset: offset,
      limit: limit,
    );

    List<Almacen> list = results.isNotEmpty
        ? results.map((e) => Almacen.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<Almacen?> obtenerPorId(int id) async {
    var db = await DatabaseHelper().db();
    final results =
        await db.rawQuery('SELECT * FROM almacen where id = ?', [id]);

    List<Almacen> list = results.isNotEmpty
        ? results.map((e) => Almacen.fromJson(e)).toList()
        : [];
    return list.isEmpty ? null : list[0];
  }

  Future<int> obtenerCantidad() async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery('SELECT COUNT(*) FROM almacen');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> insertar(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert(
      "almacen",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertarAlmacenLogin(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert(
      "almacen_login",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> actualizar(int id, Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.update(
      "almacen",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> limpiarAlmacenLogin() async {
    try {
      var db = await DatabaseHelper().db();
      await db.rawQuery('DELETE FROM almacen_login');

      return true;
    } catch (e) {
      return false;
    }
  }
}
