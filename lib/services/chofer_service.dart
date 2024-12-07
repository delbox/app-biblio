import 'package:tracking_app/common/api_client.dart';
import 'package:tracking_app/common/constantes.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class ChoferService {
  sincronizar(Sincronizacion sincronizacion) async {
    var hayRegistros = true;

    while (hayRegistros) {
      final url = Uri.parse(
          "$API_CONTEXT/api/v1/usuario/sincronizar-chofer/${sincronizacion.fechaUltimaSincronizacion}/$CANTIDAD_SINCRONIZAR");
      final response = await ApiClient().dio.get(url.toString());

      var sincronizacionData =
          SincronizacionChoferResponse.fromJson(response.data);

      if (sincronizacionData.data.registros.isNotEmpty) {
        for (var chofer in sincronizacionData.data.registros) {
          await CamionDB().insertar(chofer.toJsonChofer());
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
