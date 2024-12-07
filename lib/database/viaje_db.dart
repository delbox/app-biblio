import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class ViajeDb {
  Future<List<Viaje>> obtenerDatos() async {
    var db = await DatabaseHelper().db();
    var results = await db.query("viaje");

    List<Viaje> list = results.isNotEmpty
        ? results.map((e) => Viaje.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<Viaje>> obtenerViajesPorEstado(String estado) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Usuario usuarioLogueado = Usuario.fromJson(
        jsonDecode(preferences.getString("app-tracking-usuario")!));

    final int? almacenOrigenId = preferences.getInt("app-tracking-origen");

    final filtroUsuario = usuarioLogueado.rol == "ROLE_ALUMNO"
        ? "v.choferId = ?"
        : "v.usuarioCreacion = ? and v.almacenDestinoId = ?";

    final filtroParametros = usuarioLogueado.rol == "ROLE_ALUMNO"
        ? [usuarioLogueado.id, estado]
        : [usuarioLogueado.id, almacenOrigenId, estado];

    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
      "select "
      "v.*, ad.descripcion as almacenDestino, c.chapa, ch.nombre || ' ' || ch.apellido as chofer, "
      "ao.descripcion as almacenOrigen, coalesce(count(vc.id), 0) as cantidadCaja "
      "from viaje v "
      "join almacen ad on ad.id = v.almacenDestinoId "
      "join almacen ao on ao.id = v.almacenOrigenId "
      "join camion c on c.id = v.camionId "
      "join chofer ch on ch.id = v.choferId "
      "JOIN viaje_caja vc ON (v.idEntidad is not null and vc.viajeId = v.idEntidad) "
      "or (v.idEntidad is null and vc.viajeTmpId  = v.id) "
      "where $filtroUsuario  and v.estado = ? "
      "group by v.id, ad.descripcion, c.chapa, ch.nombre || ' ' || ch.apellido, ao.descripcion "
      "order by v.id",
      filtroParametros,
    );

    List<Viaje> list = results.isNotEmpty
        ? results.map((e) => Viaje.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<Viaje>> obtenerViajesParaRecibir() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final int? almacenOrigenId = preferences.getInt("app-tracking-origen");

    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
      "select "
      "v.*, ad.descripcion as almacenDestino, c.chapa, ch.nombre || ' ' || ch.apellido as chofer, "
      "ao.descripcion as almacenOrigen, coalesce(count(vc.id), 0) as cantidadCaja "
      "from viaje v "
      "join almacen ad on ad.id = v.almacenDestinoId "
      "join almacen ao on ao.id = v.almacenOrigenId "
      "join camion c on c.id = v.camionId "
      "join chofer ch on ch.id = v.choferId "
      "JOIN viaje_caja vc ON (v.idEntidad is not null and vc.viajeId = v.idEntidad) "
      "or (v.idEntidad is null and vc.viajeTmpId  = v.id) "
      "where v.almacenDestinoId = ? and v.estado = ? and (v.comentarioFin is null or v.comentarioFin = '') "
      "group by v.id, ad.descripcion, c.chapa, ch.nombre || ' ' || ch.apellido, ao.descripcion "
      "order by v.id",
      [almacenOrigenId, 'ENTREGADO'],
    );

    List<Viaje> list = results.isNotEmpty
        ? results.map((e) => Viaje.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<Viaje>> obtenerViajesParaModificar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Usuario usuarioLogueado = Usuario.fromJson(
        jsonDecode(preferences.getString("app-tracking-usuario").toString()));
    final int? almacenOrigenId = preferences.getInt("app-tracking-origen");

    var db = await DatabaseHelper().db();
    final results = await db.rawQuery(
      "select "
      "v.*, ad.descripcion as almacenDestino, c.chapa,  ch.nombre || ' ' || ch.apellido as chofer, "
      "ao.descripcion as almacenOrigen, coalesce(count(vc.id), 0) as cantidadCaja "
      "from viaje v "
      "join almacen ad on ad.id = v.almacenDestinoId "
      "join almacen ao on ao.id = v.almacenOrigenId "
      "join camion c on c.id = v.camionId "
      "join chofer ch on ch.id = v.choferId "
      "join viaje_caja vc ON (v.idEntidad is not null and vc.viajeId = v.idEntidad) "
      "or (v.idEntidad is null and vc.viajeTmpId  = v.id) "
      "where v.usuarioCreacion = ? and  v.almacenOrigenId = ? and v.estado = ? "
      "group by v.id, ad.descripcion, c.chapa,  ch.nombre || ' ' || ch.apellido, ao.descripcion "
      "order by v.id",
      [usuarioLogueado.id, almacenOrigenId, 'PENDIENTE'],
    );

    List<Viaje> list = results.isNotEmpty
        ? results.map((e) => Viaje.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<ViajeRequest>> obtenerViajesParaEnviar() async {
    var db = await DatabaseHelper().db();
    final results =
        await db.rawQuery("select * from viaje WHERE sincronizado = 'N'");

    List<ViajeRequest> list = results.isNotEmpty
        ? results.map((e) => ViajeRequest.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<Viaje> obtenerPorId(int id) async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery('SELECT * FROM viaje where id = ?', [id]);

    List<Viaje> list = results.isNotEmpty
        ? results.map((e) => Viaje.fromJson(e)).toList()
        : [];
    return list[0];
  }

  Future<Viaje> obtenerPorIdEntidad(int idEntidad) async {
    var db = await DatabaseHelper().db();
    final results = await db
        .rawQuery('SELECT * FROM viaje where idEntidad = ?', [idEntidad]);

    List<Viaje> list = results.isNotEmpty
        ? results.map((e) => Viaje.fromJson(e)).toList()
        : [];
    return list[0];
  }

  Future<Viaje?> existeViaje(int? idEntidad) async {
    var db = await DatabaseHelper().db();
    final results = await db
        .rawQuery('SELECT * FROM viaje where idEntidad = ?', [idEntidad]);

    List<Viaje> list = results.isNotEmpty
        ? results.map((e) => Viaje.fromJson(e)).toList()
        : [];
    return list.isNotEmpty ? list[0] : null;
  }

  Future<int> obtenerCantidad() async {
    var db = await DatabaseHelper().db();
    final results = await db.rawQuery('SELECT COUNT(*) FROM viaje');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> insertar(Map<String, dynamic> row) async {
    var db = await DatabaseHelper().db();
    return await db.insert(
      "viaje",
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> actualizar(int? id, Map<String, dynamic> row) async {
    row["id"] = id;

    var db = await DatabaseHelper().db();
    return await db.update(
      "viaje",
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> eliminar(int? id) async {
    var db = await DatabaseHelper().db();
    return await db.delete(
      "viaje",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> eliminarTodos() async {
    var db = await DatabaseHelper().db();
    return await db.delete("viaje");
  }
}
