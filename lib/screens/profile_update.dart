import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:funtastic_4/screens/my_simple_notes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user_profile.dart';
import '../../data/services/storage_service.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/providers/profile_provider.dart';
// import 'dashboard_screen.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final _displayName = TextEditingController();
  Uint8List? _photoBytes;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    // LOAD DATA (INISIALISASI) SETELAH FRAME PERTAMA SELESAI
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final auth = context.read<AuthProvider>();
      final uid = auth.uid;
      if (uid == null) return;

      await context.read<ProfileProvider>().load(uid);

      final profile = context.read<ProfileProvider>().profile;
      if (profile != null && mounted) {
        _displayName.text = profile.displayName;
        setState(() {
          _initialized = true;
        });
      }
    });
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _photoBytes = bytes;
      });
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Pembaruan Akun Berhasil'),
        content: Text(
          'Akun Anda berhasil diperbarui.\nSilahkan klik OK untuk lanjut.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MySimpleNotes()),
                (Route<dynamic> route) => false,
              ); // tutup dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final storage = context.read<StorageService>();
    final profileProvider = context.watch<ProfileProvider>();
    final uid = auth.uid;

    if (uid == null) {
      return const Scaffold(body: Center(child: Text('Belum login')));
    }
    if (!_initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final p = profileProvider.profile;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perbarui Akun Anda',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            //Tampilkan foto profil yang sudah dipilih user
                            image: _photoBytes != null
                                ? MemoryImage(_photoBytes!)
                                : (p?.photoUrl != null &&
                                          p!.photoUrl!.isNotEmpty
                                      ? NetworkImage(p.photoUrl!)
                                      : const AssetImage(
                                              'assets/images/user-icon.png',
                                            )
                                            as ImageProvider),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 1,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _displayName,
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFF1A4C8B),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: auth.loading
                            ? null
                            : () async {
                                try {
                                  String? photoUrl = p?.photoUrl;
                                  if (_photoBytes != null) {
                                    photoUrl = await storage.uploadProfilePhoto(
                                      uid,
                                      _photoBytes!,
                                    );
                                  }
                                  
                                  // Proses buat ubah email cukup rumit, jadi cuma ambil dari email sebelumnya aja.
                                  final now = DateTime.now();
                                  final updated = UserProfile(
                                    uid: uid,
                                    email: p!.email, //Pasang email sebelumnya
                                    displayName: _displayName.text.trim(),
                                    fcmToken: p.fcmToken, //pasang token sebelumnya yang udah didapat dari registrasi
                                    photoUrl: photoUrl,
                                    createdAt: p.createdAt,
                                    updatedAt: now,
                                  );
                                  await profileProvider.update(updated);
                                  if (!mounted) return;
                                  _showSuccessDialog(context);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Gagal memperbarui profil: $e',
                                      ),
                                    ),
                                  );
                                }
                              },
                        child: auth.loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Perbarui',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      // if (auth.error != null) ...[
                      //   SizedBox(height: 8),
                      //   Text(
                      //     auth.error!,
                      //     style: const TextStyle(color: Colors.red),
                      //   ),
                      // ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
