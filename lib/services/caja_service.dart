import 'package:tracking_app/common/api_client.dart';
import 'package:tracking_app/common/constantes.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class CajaService {
  sincronizar(Sincronizacion sincronizacion) async {
    var hayRegistros = true;

    while (hayRegistros) {
      final url = Uri.parse(
          "$API_CONTEXT/api/v1/caja/sincronizar/${sincronizacion.fechaUltimaSincronizacion}/$CANTIDAD_SINCRONIZAR");
      final response = await ApiClient().dio.get(url.toString());

      var sincronizacionData =
          SincronizacionCajaResponse.fromJson(response.data);

      if (sincronizacionData.data.registros.isNotEmpty) {
        for (var caja in sincronizacionData.data.registros) {
          await CajaDb().insertar(caja.toJson());
        }

        sincronizacion.fechaUltimaSincronizacion =
            sincronizacionData.data.ultimaFecha;
        await SincronizacionDb()
            .actualizar(sincronizacion.id, sincronizacion.toJson());
      }

      hayRegistros = sincronizacionData.data.registros.isNotEmpty;
    }
  }
}
