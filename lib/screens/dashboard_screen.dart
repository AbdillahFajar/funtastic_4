import 'package:flutter/material.dart';
import 'package:funtastic_4/domain/entities/user_profile.dart';
import 'package:funtastic_4/presentation/providers/auth_provider.dart';
import 'package:funtastic_4/screens/login_screen.dart';
import 'package:funtastic_4/screens/my_simple_notes.dart';
import 'package:funtastic_4/screens/notifications_screen.dart';
import '../models/menu.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'profile_update.dart';
import '../data/services/user_service.dart';
import 'package:provider/provider.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  List<Menu> menus = [];

  void _getMenus() {
    menus = Menu.getMenus();
  }

  @override
  void initState() {
    super.initState();
    _getMenus();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi\nPengembang',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,

        //Ikon pojok kanan
        actions: [
          IconButton(
            onPressed: () {
              //Bikin navigasi ke file notifications_screen.dart
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyNotifications()),
              );
            },
            icon: Icon(Icons.notifications, color: Color(0xFFE69500)),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileUpdate()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      drawer: Drawer(
        child: StreamBuilder<UserProfile>(
          stream: context.read<UserService>().userStream(
            fb.FirebaseAuth.instance.currentUser!.uid,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = snapshot.data!;

            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(user.displayName),
                  accountEmail: Text(user.email),
                  currentAccountPicture: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            user.photoUrl != null && user.photoUrl!.isNotEmpty
                            ? NetworkImage(user.photoUrl!)
                            : const AssetImage('assets/images/user-icon.png')
                                  as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  decoration: const BoxDecoration(color: Color(0xFF253858)),
                ),
                ListTile(
                  leading: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage("assets/icons/note.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  title: const Text("Simple Notes"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MySimpleNotes(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () async {
                    final nav = Navigator.of(context);
                    await auth.signOut();
                    nav.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D1617),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  itemCount: menus.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 25);
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: menus[index].boxColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(menus[index].icon, size: 50),
                          Text(
                            menus[index].name,
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
                                  menus[index].viewIsSelected
                                      ? const Color(0xff92A3FD)
                                      : Colors.transparent,
                                  menus[index].viewIsSelected
                                      ? const Color(0xff92A3FD)
                                      : Colors.transparent,
                                  menus[index].viewIsSelected
                                      ? const Color(0xff92A3FD)
                                      : Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (menus[index].page == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Menu ini akan segera hadir',
                                      ),
                                    ),
                                  );

                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => menus[index].page!,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: menus[index].viewIsSelected
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
                                  color: menus[index].viewIsSelected
                                      ? Colors.white
                                      : const Color(0xffC58BF2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
