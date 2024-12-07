import 'package:flutter/material.dart';
import 'package:tracking_app/screens/screens.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/login': (context) => const LoginScreen(),
    '/loading': (context) => const LoadingScreen(),
    '/home-chofer': (context) => const HomeChoferScreen(),
    '/home-deposito': (context) => const HomeDepositoScreen(),
    '/home-deposito-enviar': (context) => const HomeDepositoEnviarScreen(),
    '/home-deposito-modificar': (context) => const HomeDepositoModificarScreen(),
    '/enviar/almacen': (context) => const EnviarAlmacenScreen(),
    '/enviar/cajas': (context) => const EnviarCajasScreen(),
    '/enviar/chofer': (context) => const EnviarChoferScreen(),
    '/home-deposito-recibir': (context) => const HomeDepositoRecibirScreen(),
    '/recibir/cajas': (context) => const RecibirCajasScreen(),
    '/recibir/comentario': (context) => const RecibirComentarioScreen(),
    '/detalle-viaje': (context) => const DetalleViajeScreen(),
    '/configuracion': (context) => const ConfiguracionScreen(),
  };
}
