import 'package:flutter/material.dart';
import 'package:funtastic_4/screens/profiles/fajar_abdillah/fajar_abdillah.dart';
import 'package:funtastic_4/screens/profiles/damar_bagas/damar_bagas.dart';
import 'package:funtastic_4/screens/profiles/moh_frendy/moh_frendy.dart';
import 'package:funtastic_4/screens/profiles/rayen_tenri/rayen_tenri.dart';

class Team {
  String nama;
  String foto;
  Color boxColor;
  bool viewIsSelected;
  Widget? page;

  Team({
    required this.nama,
    required this.foto,
    required this.boxColor,
    required this.viewIsSelected,
    required this.page,
  });

  static List<Team> getTeams() {
    List<Team> teams = [
      Team(
        nama: "Fajar\nAbdillah",
        foto: 'assets/images/Fajar.jpeg',
        boxColor: Color(0xff92A3FD),
        viewIsSelected: true,
        page: FajarAbdillah(),
      ),
      Team(
        nama: "Muhammad\nDamar Bagas",
        foto: 'assets/images/Damar.jpeg',
        boxColor: Color(0xffEEA4CE),
        viewIsSelected: false,
        page: DamarBagas(),
      ),
      Team(
        nama: "Frendy Aprianto",
        foto: 'assets/images/Frendy.jpeg',
        boxColor: Color(0xff92A3FD),
        viewIsSelected: true,
        page: FrendyAprianto(),
      ),
      Team(
        nama: "Rayhandi\nTenri",
        foto: 'assets/images/Rayen.jpeg',
        boxColor: Color(0xffEEA4CE),
        viewIsSelected: false,
        page: RayhandiTenri(),
      ),
    ];

    return teams;
  }
}
