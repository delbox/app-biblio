import 'package:tracking_app/common/api_client.dart';
import 'package:tracking_app/common/constantes.dart';
import 'package:tracking_app/database/databases.dart';
import 'package:tracking_app/models/models.dart';

class AlmacenService {
  sincronizar(Sincronizacion sincronizacion) async {
    var hayRegistros = true;

    while (hayRegistros) {
      final url = Uri.parse(
          "$API_CONTEXT/api/v1/almacen/sincronizar/${sincronizacion.fechaUltimaSincronizacion}/$CANTIDAD_SINCRONIZAR");
      final response = await ApiClient().dio.get(url.toString());

      var sincronizacionData =
          SincronizacionAlmacenResponse.fromJson(response.data);

      if (sincronizacionData.data.registros.isNotEmpty) {
        for (var almacen in sincronizacionData.data.registros) {
          await AlmacenDb().insertar(almacen.toJson());
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
