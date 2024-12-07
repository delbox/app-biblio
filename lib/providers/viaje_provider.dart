import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/database/caja_db.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/database/viaje_cajas_db.dart';
import 'package:tracking_app/database/viaje_db.dart';
import 'package:tracking_app/models/models.dart';
import 'package:tracking_app/services/viaje_service.dart';

class ViajeProvider extends ChangeNotifier {
  var viajeNuevo = Viaje(
    id: null,
    almacenOrigenId: null,
    almacenDestinoId: null,
    camionId: null,
    choferId: null,
    fechaCreacion: null,
    usuarioCreacion: null,
  );

  List<Caja> cajas = [];
  List<ViajeCajaRecibir> cajasRecibir = [];

  List<Viaje> viajesPendienteChofer = [];
  List<Viaje> viajesEnCaminoChofer = [];

  Future<Caja?> obtenerCajaPorCodigo(String codigo) async {
    final registro = await CajaDb().obtenerPorCodigo(codigo);
    return registro;
  }

  agregarCajas(Caja caja) {
    cajas.add(caja);
    notifyListeners();
  }

  eliminarCaja(Caja caja) {
    cajas.remove(caja);
    notifyListeners();
  }

  agregarCajasRecibir(ViajeCajaRecibir caja) {
    cajasRecibir.add(caja);
    notifyListeners();
  }

  eliminarCajaRecibir(int index) {
    cajasRecibir.removeAt(index);
    notifyListeners();
  }

  obtenerCajasRecibirPorViajeId(int viajeId) async {
    cajasRecibir = await ViajeCajasRecibirDB().obtenerCajasPorViaje(viajeId);
    notifyListeners();
  }

  limpiarViajeForm() {
    viajeNuevo = Viaje(
      id: null,
      almacenOrigenId: null,
      almacenDestinoId: null,
      almacenDestino: null,
      camionId: null,
      choferId: null,
      fechaCreacion: null,
      usuarioCreacion: null,
    );
    cajas = [];
    notifyListeners();
  }

  limpiarViajeRecibir() {
    cajasRecibir = [];
    notifyListeners();
  }

  obtenerViajesPendientesChofer() async {
    viajesPendienteChofer = await ViajeDb().obtenerViajesPorEstado("ASIGNADO");
    notifyListeners();
  }

  obtenerViajesEnCaminoChofer() async {
    viajesEnCaminoChofer = await ViajeDb().obtenerViajesPorEstado("EN_CAMINO");
    notifyListeners();
  }

  Future<List<Viaje>> obtenerViajesPorEstado(String estado) async {
    return ViajeDb().obtenerViajesPorEstado(estado);
  }

  Future<List<Viaje>> obtenerViajesParaModificar() async {
    return ViajeDb().obtenerViajesParaModificar();
  }

  Future<List<Viaje>> obtenerViajesParaRecibir() async {
    return ViajeDb().obtenerViajesParaRecibir();
  }

  Future<List<Caja>> obtenerCajaPorViaje(int viajeId) async {
    final registro = await ViajeCajaDb().obtenerPorViaje(viajeId);
    return registro;
  }

  Future<List<Caja>> obtenerCajasDeViaje(int viajeId) async {
    final registro = await ViajeCajaDb().obtenerCajasDeViaje(viajeId);
    return registro;
  }

  Future<ViajeResponse?> iniciarViaje(int viajeId, BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      final viajeResponse = await ViajeService().iniciarViaje(viajeId);
      if (viajeResponse.error == false) {
        final viaje = await ViajeDb().obtenerPorIdEntidad(viajeId);
        viaje.estado = "EN_CAMINO";

        await ViajeDb().actualizar(viajeId, viaje.toJson());
      }

      return viajeResponse;
    } catch (e) {
      if (e is DioException) {
        navigator.pushReplacementNamed("/login");
      }
      return null;
    }
  }

  Future<ViajeResponse?> marcarLlegada(
      int viajeId, BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      final viajeResponse = await ViajeService().marcarLlegada(viajeId);
      if (viajeResponse.error == false) {
        final viaje = await ViajeDb().obtenerPorIdEntidad(viajeId);
        viaje.estado = "ENTREGADO";

        await ViajeDb().actualizar(viajeId, viaje.toJson());
      }

      return viajeResponse;
    } catch (e) {
      if (e is DioException) {
        navigator.pushReplacementNamed("/login");
      }
      return null;
    }
  }

  obtenerChoferPorId(int id) async {
    Usuario? chofer = await UsuarioDb().obtenerPorId(id);
    viajeNuevo.chofer = "${chofer!.nombre} ${chofer.apellido}";
  }
}
