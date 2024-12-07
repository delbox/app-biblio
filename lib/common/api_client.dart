import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio dio;

  ApiClient() : dio = Dio() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        final token = preferences.getString("app-tracking-token") ?? "";

        options.headers['Content-Type'] = 'application/json; charset=UTF-8';
        if (token != "" && token != "null") {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
    ));
  }
}
