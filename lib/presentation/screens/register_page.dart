import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:funtastic_4/presentation/screens/loading_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../data/services/storage_service.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
// import 'dashboard_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final messaging = FirebaseMessaging.instance;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _displayName = TextEditingController();
  Uint8List? _photoBytes;
  bool _obscure = true;

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
        title: const Text('Registrasi Berhasil'),
        content: Text(
          'Akun Anda berhasil dibuat.\nSilahkan klik OK untuk lanjut.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // tutup dialog

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoadingScreen()),
                (route) => false,
              );
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
    final profileProvider = context.read<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Akun',
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
                                : const AssetImage(
                                        'assets/images/user-icon.png',
                                      )
                                      as ImageProvider,
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
                        controller: _email,
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _password,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
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
                                  await auth.signUp(
                                    _email.text.trim(),
                                    _password.text,
                                  );
                                  if (auth.uid != null) {
                                    String? photoUrl;
                                    if (_photoBytes != null) {
                                      photoUrl = await storage
                                          .uploadProfilePhoto(
                                            auth.uid!,
                                            _photoBytes!,
                                          );
                                    }
                                    final now = DateTime.now();
                                    final token = await messaging.getToken();
                                    final profile = UserProfile(
                                      uid: auth.uid!,
                                      email: _email.text.trim(),
                                      displayName: _displayName.text.trim(),
                                      fcmToken: token,
                                      photoUrl: photoUrl,
                                      createdAt: now,
                                      updatedAt: now,
                                    );
                                    await profileProvider.update(profile);

                                    if (!mounted) return;

                                    if (auth.error == null) {
                                      _showSuccessDialog(context);
                                    }
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Registrasi akun gagal: ${e.toString()}',
                                      ),
                                    ),
                                  );
                                }
                              },
                        child: auth.loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Daftar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      if (auth.error != null) ...[
                        SizedBox(height: 8),
                        Text(
                          auth.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
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