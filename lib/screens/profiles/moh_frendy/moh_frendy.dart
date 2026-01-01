import 'package:flutter/material.dart';

class FrendyAprianto extends StatelessWidget {
  const FrendyAprianto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Frendy Aprianto",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        
      ),
    );
  }
}