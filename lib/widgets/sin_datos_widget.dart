import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SinDatosWidget extends StatelessWidget {
  const SinDatosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(5),
        color: const Color(0xFFE6E6E6),
        child: ListTile(
          onTap: () {},
          minLeadingWidth: 0,
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.book,
                color: Color(0xFF9B9B9B),
                size: 15,
              ),
            ],
          ),
          title: const Row(
            children: [
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No se encontraron préstamos",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
