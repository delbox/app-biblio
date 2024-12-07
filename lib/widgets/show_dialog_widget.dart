import 'package:flutter/material.dart';
import 'package:tracking_app/theme/app_theme.dart';

showDialogWidget(BuildContext context,
        {String texto = "Cargando...", bool actions = false}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(texto),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              actions
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Aceptar'),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
            ],
          ),
        );
      },
    );
