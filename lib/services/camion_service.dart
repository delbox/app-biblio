import 'package:tracking_app/common/api_client.dart';
import 'package:tracking_app/common/constantes.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class CamionService {
  sincronizar(Sincronizacion sincronizacion) async {
    var hayRegistros = true;

    while (hayRegistros) {
      final url = Uri.parse(
          "$API_CONTEXT/api/v1/camion/sincronizar/${sincronizacion.fechaUltimaSincronizacion}/$CANTIDAD_SINCRONIZAR");
      final response = await ApiClient().dio.get(url.toString());

      var sincronizacionData =
          SincronizacionCamionResponse.fromJson(response.data);

      if (sincronizacionData.data.registros.isNotEmpty) {
        for (var camion in sincronizacionData.data.registros) {
          await CamionDB().insertar(camion.toJson());
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
