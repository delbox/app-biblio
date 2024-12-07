import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/providers/providers.dart';

class CabeceraHomeWidget extends StatelessWidget {
  const CabeceraHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Image(
              image: AssetImage("assets/img/logo-tracking.png"),
              width: 60, // Cambia el tamaño según tus necesidades
              height: 60,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "",
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF363636),
                  ),
                ),
                const Text(
                  "Bienvenida/o,",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF363636),
                  ),
                ),
                const Text(
                  "Raquel Gonzalez",
                  //authProvider.usuarioLogueado.usuario,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF363636),
                  ),
                ),

                SizedBox(
                  width: 190,
                  child: Text(
                    authProvider.almacenOrigen,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF363636),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        authProvider.usuarioLogueado.rol == 'ROLE_ALUMNO'
            ? Container()
            : IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed("/configuracion"),
                icon: const Icon(
                  FontAwesomeIcons.gear,
                  color: Color.fromARGB(255, 110, 110, 110),
                ),
              ),
      ],
    );
  }
}
