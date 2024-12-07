import 'package:flutter/material.dart';
import 'package:tracking_app/theme/app_theme.dart';

class BotonesAccionDepositoWidget extends StatelessWidget {
  final String textoPrimerBoton;
  final IconData iconPrimerBoton;
  final Function() functionPrimerBoton;

  final String textoSegundoBoton;
  final IconData iconSegundoBoton;
  final Function() functionSegundoBoton;

  const BotonesAccionDepositoWidget({
    super.key,
    required this.textoPrimerBoton,
    required this.iconPrimerBoton,
    required this.functionPrimerBoton,
    required this.textoSegundoBoton,
    required this.iconSegundoBoton,
    required this.functionSegundoBoton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "¿Que deseas hacer?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: TextButton(
            onPressed: functionPrimerBoton,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconPrimerBoton),
                const SizedBox(width: 15),
                Text(textoPrimerBoton),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: TextButton(
            onPressed: functionSegundoBoton,
            style: TextButton.styleFrom(
              backgroundColor: AppTheme.secondaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconSegundoBoton),
                const SizedBox(width: 15),
                Text(textoSegundoBoton),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
