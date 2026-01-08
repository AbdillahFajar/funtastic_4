import 'package:flutter/material.dart';
import 'package:funtastic_4/presentation/screens/team_screen.dart';

class Menu {
  String name;
  IconData icon;
  Color boxColor;
  bool viewIsSelected;
  Widget? page;

  Menu({
    required this.name,
    required this.icon,
    required this.boxColor,
    required this.viewIsSelected,
    required this.page,
  });

  static List<Menu> getMenus () {
    List<Menu> menus = [];

    menus.add(
      Menu(
        name: 'Profil Tim\nFuntastic 4',
        icon: Icons.groups,
        boxColor: Color(0xff92A3FD),
        viewIsSelected: true,
        page: MyTeam()
      ),
    );

    menus.add(
      Menu(
        name: 'Coming Soon',
        icon: Icons.upcoming,
        boxColor: Color(0xffEEA4CE),
        viewIsSelected: false,
        page: null
      ),
    );

    return menus;
  }
}
