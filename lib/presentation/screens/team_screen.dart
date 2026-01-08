import 'package:flutter/material.dart';
import '../../models/team.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({super.key});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  List<Team> teams = [];

  void _getTeams() {
    teams = Team.getTeams();
  }

  @override
  void initState() {
    super.initState();
    _getTeams();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anggota Tim',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded( //pake Expanded supaya semua item di menu ini kelihatan dan dengan ListView yang nerapin scroll, semua item tampil sesuai layar dan bisa di-scroll jika item-item yang ada, sudah memenuhi ukuran maksimal layar
            child: ListView.separated(
              itemCount: teams.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 25);
              },
              itemBuilder: (context, index) {
                return Container(
                  // width: 160,
                  decoration: BoxDecoration(
                    color: teams[index].boxColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(teams[index].foto),
                              fit: BoxFit.fill,
                            ),
                            // border: BoxBorder.all(color: Colors.black)
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          teams[index].nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                teams[index].viewIsSelected
                                    ? const Color(0xff92A3FD)
                                    : Colors.transparent,
                                teams[index].viewIsSelected
                                    ? const Color(0xff92A3FD)
                                    : Colors.transparent,
                                teams[index].viewIsSelected
                                    ? const Color(0xff92A3FD)
                                    : Colors.transparent,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (teams[index].page == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Profil ${teams[index].nama} belum dibuat'),
                                  ),
                                );
                    
                                return;
                              }
                    
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => teams[index].page!,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: teams[index].viewIsSelected
                                  ? const Color(0xff92A3FD)
                                  : Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              'Lihat',
                              style: TextStyle(
                                color: teams[index].viewIsSelected
                                    ? Colors.white
                                    : const Color(0xffC58BF2),
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}