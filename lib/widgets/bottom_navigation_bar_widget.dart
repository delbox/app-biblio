import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/models/models.dart';
import 'package:tracking_app/theme/app_theme.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  final _bottomNavIndex = 0;
  var locationEnabled = false;

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.arrowRightToBracket,
  ];

  void _onItemTapped(int index, BuildContext context) async {
    final navigator = Navigator.of(context);
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    if (index == 0) {
      final usuarioStr =
          preferences.getString("app-tracking-usuario").toString();
      final usuario = Usuario.fromJson(jsonDecode(usuarioStr));

      if (usuario.rol == "ROLE_ALUMNO") {
        navigator.pushNamed('/home-chofer');
      } else if (usuario.rol == "ROLE_BIBLIOTECARIO") {
        navigator.pushNamed('/home-deposito');
      }
    }

    if (index == 1) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      await preferences.clear();

      navigator.pushReplacementNamed('/login');
    }
  }

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index],
              color: Colors.white,
            ),
          ],
        );
      },
      backgroundColor: AppTheme.primaryColor,
      activeIndex: _bottomNavIndex,
      splashColor: AppTheme.primaryColor,
      notchAndCornersAnimation: borderRadiusAnimation,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      onTap: (index) => _onItemTapped(index, context),
      hideAnimationController: _hideBottomBarAnimationController,
    );
  }
}
