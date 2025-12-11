import 'package:flutter/material.dart';
import 'package:funtastic_4/screens/login_screen.dart';
import 'package:funtastic_4/screens/notifications_screen.dart';
import '../models/menu.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Utama',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        //Ikon pojok kanan
        actions: [
          IconButton(
            onPressed: () {
              //Bikin navigasi ke file notifications_screen.dart
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyNotifications())
              );
            }, 
            icon: Icon (
              Icons.notifications,
              color: Color(0xFFE69500),
            )
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Andrew Garfield"),
              accountEmail: const Text("capek@ngoding.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1600486913747-55e5470d6f40?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                ),
              ),
              decoration: BoxDecoration(color: Colors.blueGrey[900]),
              otherAccountsPictures: const [
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage(
                //       "https://randomuser.me/api/portraits/women/74.jpg"),
                // ),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage(
                //       "https://randomuser.me/api/portraits/men/47.jpg"),
                // ),
              ],
            ),
            // ListTile(
            //   leading: const Icon(Icons.home),
            //   title: const Text("Home"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: const Icon(Icons.code),
            //   title: const Text("About"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: const Icon(Icons.rule),
            //   title: const Text("TOS"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: const Icon(Icons.privacy_tip),
            //   title: const Text("Privacy Policy"),
            //   onTap: () {},
            // ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                );
              },
            ),
          ],
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
                    'Fitur',
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
                        children:[
                          Icon(
                            menus[index].icon,
                            size: 50
                          ),
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
                                  menus[index].viewIsSelected ? const Color(0xff92A3FD) : Colors.transparent,
                                  menus[index].viewIsSelected ? const Color(0xff92A3FD) : Colors.transparent,
                                  menus[index].viewIsSelected ? const Color(0xff92A3FD) : Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if(menus[index].page == null)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Fitur ini akan segera hadir'))
                                  );

                                  return;
                                }
                                
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => menus[index].page!
                                  )
                                );
                              }, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: menus[index].viewIsSelected ? const Color(0xff92A3FD) : Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                                ),
                              ),
                              child: Text(
                              'Lihat',
                              style: TextStyle(
                                color: menus[index].viewIsSelected ? Colors.white : const Color(0xffC58BF2),
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            )
                          ),
                        ],
                      ),
                    );
                  }
                  )
                ),
              ],
            ),
          ),
        ),
    );
  }
}
