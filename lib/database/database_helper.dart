import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "farmacenter_tracking_app.db";
  static const _databaseVersion = 1;

  Future<Database> db() async {
    return openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    String script = await rootBundle.loadString("assets/db/scripts.sql");
    List<String> scripts = script.split(";");

    for (var element in scripts) {
      if (element.isNotEmpty) {
        db.execute(element.trim());
      }
    }
  }

  Future insertarDatosInicialesSincronizacion() async {
    var database = await db();
    var result = await database.rawQuery('SELECT COUNT(*) FROM sincronizacion');

    if (Sqflite.firstIntValue(result) == 0) {
      List<String> list = ["caja", "almacen", "camion", "usuario"];
      for (var i = 0; i < list.length; i++) {
        database.insert(
          "sincronizacion",
          {"tabla": list[i], "fechaUltimaSincronizacion": 0},
        );
      }
    }
  }

}
