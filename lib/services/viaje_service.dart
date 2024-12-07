import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/common/api_client.dart';
import 'package:tracking_app/common/constantes.dart';
import 'package:tracking_app/database/viaje_cajas_db.dart';
import 'package:tracking_app/database/viaje_cajas_recibir_db.dart';
import 'package:tracking_app/database/viaje_db.dart';
import 'package:tracking_app/models/models.dart';

class ViajeService {
  descargarViajes() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final usuarioLogueado = Usuario.fromJson(
        jsonDecode(preferences.getString("app-tracking-usuario").toString()));

    final url = Uri.parse("$API_CONTEXT/api/v1/viaje");
    final response = await ApiClient().dio.get(url.toString());

    final viajeResponseSync = ViajeResponseSync.fromJson(response.data);

    await ViajeDb().eliminarTodos();
    await ViajeCajaDb().eliminarTodos();

    for (var viajeSync in viajeResponseSync.data) {
      Viaje viaje = Viaje(
        idEntidad: viajeSync.id,
        almacenOrigenId: viajeSync.almacenOrigen.id,
        almacenDestinoId: viajeSync.almacenDestino.id,
        camionId: viajeSync.camion.id,
        choferId: viajeSync.chofer.id,
        sincronizado: "S",
        estado: viajeSync.estado,
        fechaCreacion: viajeSync.fechaCreacion,
        usuarioCreacion: usuarioLogueado.id,
      );

      await ViajeDb().insertar(viaje.toJson());

      for (var caja in viajeSync.cajas) {
        ViajeCaja viajeCaja = ViajeCaja(
          viajeId: viajeSync.id,
          cajaId: caja.id,
          fechaCreacion: caja.fechaCreacion,
          usuarioCreacion: usuarioLogueado.id,
        );

        await ViajeCajaDb().insertar(viajeCaja.toJson());
      }
    }
  }

  enviarViajes() async {
    final List<ViajeRequest> viajes = await ViajeDb().obtenerViajesParaEnviar();

    for (var viajeRequest in viajes) {
      final int? id = viajeRequest.id;

      if (viajeRequest.idEntidad == null || viajeRequest.idEntidad == 0) {
        viajeRequest.cajas = await ViajeCajaDb().obtenerPorViajeIdMap(id);
        if (viajeRequest.cajas.isNotEmpty &&
            viajeRequest.camion["id"] != null) {
          await ApiClient().dio.post(
                Uri.parse("$API_CONTEXT/api/v1/viaje").toString(),
                data: viajeRequest,
                options: Options(contentType: Headers.jsonContentType),
              );
        }
      } else {
        viajeRequest.cajas = await ViajeCajaDb()
            .obtenerPorViajeIdEntidadMap(viajeRequest.idEntidad);
        viajeRequest.id = viajeRequest.idEntidad;
        if (viajeRequest.cajas.isNotEmpty &&
            viajeRequest.camion["id"] != null) {
          await ApiClient().dio.put(
                Uri.parse("$API_CONTEXT/api/v1/viaje/${viajeRequest.idEntidad}")
                    .toString(),
                data: viajeRequest,
                options: Options(contentType: Headers.jsonContentType),
              );
        }
      }
    }
  }

  enviarViajesCajaRecibida() async {
    final List<Map<String, dynamic>> viajes =
        await ViajeCajasRecibirDB().obtenerViajes();

    for (var viaje in viajes) {
      final viajeId = viaje["viajeId"];
      final cajas = await ViajeCajasRecibirDB().obtenerPorViajeMap(viajeId);

      ViajeFinalizarRequest viajeFinalizarRequest =
          ViajeFinalizarRequest(cajas: cajas);

      final Response response;
      if (viajeFinalizarRequest.cajas.isNotEmpty) {
        response = await ApiClient().dio.put(
              Uri.parse("$API_CONTEXT/api/v1/viaje/finalizar/$viajeId")
                  .toString(),
              data: viajeFinalizarRequest,
              options: Options(contentType: Headers.jsonContentType),
            );

        final viajeResponse = ViajeFinalizarResponse.fromJson(response.data);
        if (viajeResponse.error == false) {
          await ViajeCajasRecibirDB().eliminarPorViaje(viajeId);
        }
      }
    }
  }

  Future<ViajeResponse> iniciarViaje(int viajeId) async {
    final response = await ApiClient().dio.put(
          Uri.parse("$API_CONTEXT/api/v1/viaje/iniciar/$viajeId").toString(),
          options: Options(contentType: Headers.jsonContentType),
        );

    return ViajeResponse.fromJson(response.data);
  }

  Future<ViajeResponse> marcarLlegada(int viajeId) async {
    final response = await ApiClient().dio.put(
          Uri.parse("$API_CONTEXT/api/v1/viaje/entregar/$viajeId").toString(),
          options: Options(contentType: Headers.jsonContentType),
        );

    return ViajeResponse.fromJson(response.data);
  }

  Future<ViajeResponse?> asignarViaje(int viajeId, BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      final response = await ApiClient().dio.put(
            Uri.parse("$API_CONTEXT/api/v1/viaje/asignar/$viajeId").toString(),
            options: Options(contentType: Headers.jsonContentType),
          );

      return ViajeResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        navigator.pushReplacementNamed("/login");
      }
      return null;
    }
  }

  Future<ViajeResponse?> cancelarViaje(
      int viajeId, String observacion, BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      final response = await ApiClient().dio.delete(
            Uri.parse("$API_CONTEXT/api/v1/viaje/cancelar/$viajeId").toString(),
            data: {"observacion": observacion},
            options: Options(contentType: Headers.jsonContentType),
          );

      return ViajeResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        navigator.pushReplacementNamed("/login");
      }
      return null;
    }
  }
}
