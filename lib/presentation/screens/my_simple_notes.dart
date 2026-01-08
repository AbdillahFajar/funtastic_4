import 'package:flutter/material.dart';
import 'package:funtastic_4/domain/entities/user_profile.dart';
import 'package:funtastic_4/presentation/providers/auth_provider.dart';
import 'package:funtastic_4/presentation/screens/dashboard_screen.dart';
import 'package:funtastic_4/presentation/screens/login_screen.dart';
import '../../data/services/database_helper.dart';
import '../../models/note.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'notifications_screen.dart';
import 'profile_update.dart';
import 'package:provider/provider.dart';
import '../../data/services/user_service.dart';

class MySimpleNotes extends StatefulWidget {
  const MySimpleNotes({super.key});

  @override
  State<MySimpleNotes> createState() => _MySimpleNotesState();
}

class _MySimpleNotesState extends State<MySimpleNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final uid = fb.FirebaseAuth.instance.currentUser!.uid;

  //Membuat fungsi untuk menampilkan form tambah catatan
  void _showForm({Note? note}) {
    if (note != null) {
      //mengambil teks dari input field ketika field tidak kosong
      _titleController.text = note.title;
      _contentController.text = note.content;
    } else {
      //membersihkan field
      _titleController.clear();
      _contentController.clear();
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      //agar form bisa full screen saat keyboard muncul
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          //Padding bawah mengikuti tinggi keyboard agar form tidak tertutup
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Judul'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Ketikan catatan Anda di sini...',
              ),
              maxLines: 3, //untuk memperluas area ketikan
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                //mengambil teks dari controller
                final title = _titleController.text;
                final content = _contentController.text;

                //jangan simpan catatan jika salah satu field-nya kosong
                if (title.isEmpty || content.isEmpty) return;

                if (note == null) {
                  //Menyimpan teks yang diambil tadi ke database. ini untuk membuat catatan baru
                  await DatabaseHelper.instance.create(
                    Note(userId: uid, title: title, content: content),
                  );
                } else {
                  //Memperbarui catatan yang dipilih
                  await DatabaseHelper.instance.update(
                    Note(
                      id: note.id,
                      userId: uid,
                      title: title,
                      content: content,
                    ),
                  );
                }
                //3. menutup form dan me-refresh UI
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text(note == null ? 'Simpan' : 'Perbarui'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catatan Anda',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                    // child: CircleAvatar(
                    //   radius: 60,
                    //   backgroundImage: AssetImage(
                    //     'assets/images/Fajar.jpeg',
                    //   ),
                    // ),
                  ),
                  // CircleAvatar(
                  //   backgroundImage:
                  //       user.photoUrl != null && user.photoUrl!.isNotEmpty
                  //       ? NetworkImage(user.photoUrl!)
                  //       : const AssetImage('assets/images/user-icon.png')
                  //             as ImageProvider,
                  // ),
                  decoration: const BoxDecoration(color: Color(0xFF253858)),
                ),

                ListTile(
                  leading: const Icon(Icons.groups),
                  title: const Text("Informasi\nPengembang"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyDashboard(),
                      ),
                      (route) => false,
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
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),

      body: FutureBuilder<List<Note>>(
        future: DatabaseHelper.instance.readUserNotes(uid),
        builder: (context, snapshot) {
          //kondisi untuk menampilkan tulisan ketika aplikasi masih loading atau ketika user sudah masuk aplikasi, tapi belum ada catatan yang dibuatnya sama sekali
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(
              child: Text(
                ('Anda belum memiliki catatan apapun'),
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            );

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Note note = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  //bikin ikon di daerah kanan (belakang) card list tile-nya
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await DatabaseHelper.instance.delete(note.id!, uid);
                      setState(() {});
                    },
                  ),
                  onTap: () {
                    _showForm(note: note);
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Tambah catatan baru.",
        child: Icon(Icons.add),
        onPressed: () async {
          _showForm(); //panggil fungsi pembuka form
          setState(() {});
        },
      ),
    );
  }
}