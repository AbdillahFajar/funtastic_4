import 'package:flutter/material.dart';

class DamarBagas extends StatelessWidget {
  const DamarBagas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Damar Bagas",
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
          'Profil Damar Bagas'
        ),
      )
    );
  }
}