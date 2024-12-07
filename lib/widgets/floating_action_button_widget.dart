import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracking_app/services/services.dart';
import 'package:tracking_app/theme/app_theme.dart';
import 'package:tracking_app/widgets/widgets.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  sincronizar() async {
    final navigator = Navigator.of(context);
    showDialogWidget(context);
    if (await SincronizacionService().sincronizar(context)) {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppTheme.secondaryColor,
      onPressed: sincronizar,
      child: const Icon(
        FontAwesomeIcons.arrowsRotate,
        color: Colors.white,
      ),
    );
  }
}
