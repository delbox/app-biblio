import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CabeceraSecundariaWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String titulo;
  final String? url;

  const CabeceraSecundariaWidget({
    super.key,
    required this.titulo,
    this.url,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            if (url == null) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushNamed(url!);
            }
          },
          child: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 20,
          ),
        ),
      ),
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
