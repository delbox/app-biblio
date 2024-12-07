import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class SincronizacionDb {
  Future<List<Sincronizacion>> obtenerDatos() async {
    var db = await DatabaseHelper().db();
    var results = await db.query("sincronizacion");

    List<Sincronizacion> list = results.isNotEmpty
        ? results.map((e) => Sincronizacion.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<int> actualizar(int id, Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.update(
      "sincronizacion",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
