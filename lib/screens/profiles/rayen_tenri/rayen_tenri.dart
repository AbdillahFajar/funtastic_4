import 'package:flutter/material.dart';

class RayhandiTenri extends StatelessWidget {
  const RayhandiTenri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rayhandi Tenri",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Profil Rayhandi Tenri'
        ),
      )
    );
  }
}