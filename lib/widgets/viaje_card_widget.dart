import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracking_app/theme/colores_estado.dart';

class ViajeWidget extends StatelessWidget {
  final int index;

  const ViajeWidget(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.truck,
                color: Color(0xFF9B9B9B),
                size: 15,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Entrega ${index + 1}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        "ABC 123",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF9B9B9B),
                        ),
                      ),
                      Text(" - "),
                      Text(
                        "En Camino",
                        style: TextStyle(
                          fontSize: 15,
                          color: ColoresEstado.PENDIENTE,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
