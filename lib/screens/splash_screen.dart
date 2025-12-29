import '../presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'my_simple_notes.dart';
import 'package:flutter/material.dart';
import 'package:funtastic_4/screens/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async { //Gunakan ini untuk mempersiapkan agar context bisa dipakai untuk navigasi dan insialisasi AuthStateChanges
      await Future.delayed(const Duration(seconds: 2)); //Buat delay animasi selama 2 detik

      if (!mounted) return; //cek apakah widget halaman ini masih ada atau enggak, kalau sudah gak ada, maka kode di bawahnya ini tidak akan dijalankan

      final auth = context.read<AuthProvider>(); //pake AuthStateChanges dari Firebase Auth yang sudah sinkron dengan AuthProvider untuk menghindari akun user lain yang masih nyangkut ketika fresh install dilakukan

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              auth.uid == null ? const LoginScreen() : const MySimpleNotes(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/GI-logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            SizedBox(height: 10),

            Lottie.asset(
              'assets/animations/Material wave loading.json',
              width: 200,
              height: 100,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}