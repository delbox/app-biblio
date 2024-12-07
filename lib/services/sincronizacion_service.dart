import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';
import 'package:tracking_app/providers/providers.dart';
import 'package:tracking_app/services/services.dart';

class SincronizacionService {
  Future<bool> sincronizar(BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      final viajeProvider = Provider.of<ViajeProvider>(context, listen: false);
      var sincronizaciones = await SincronizacionDb().obtenerDatos();

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final usuarioLogueado = Usuario.fromJson(
          jsonDecode(preferences.getString("app-tracking-usuario").toString()));

      // se envia todo
      if (usuarioLogueado.rol == "ROLE_BIBLIOTECARIO") {
        await ViajeService().enviarViajes();
        await ViajeService().enviarViajesCajaRecibida();
      }

      // se descarga todo
      for (var sincronizacion in sincronizaciones) {
        if (sincronizacion.tabla == "caja") {
          await CajaService().sincronizar(sincronizacion);
        } else if (sincronizacion.tabla == "almacen") {
          await AlmacenService().sincronizar(sincronizacion);
        } else if (sincronizacion.tabla == "camion") {
          await CamionService().sincronizar(sincronizacion);
        } else if (sincronizacion.tabla == "usuario") {
          await ChoferService().sincronizar(sincronizacion);
        }
      }

      await ViajeService().descargarViajes();

      viajeProvider.obtenerViajesEnCaminoChofer();
      viajeProvider.obtenerViajesPendientesChofer();

      return true;
    } catch (e) {
      if (e is DioException) {
        navigator.pushReplacementNamed("/login");
      }

      return false;
    }
  }
}
