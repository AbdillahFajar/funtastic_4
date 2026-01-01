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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.blueGrey,
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    const AssetImage('assets/images/Frendy.jpeg'),
              ),
            ),

            const SizedBox(height: 16),

            //name
            const Text(
              "Moh Frendy Aprianto",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            //subtitle
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Mahasiswa Informatika",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 30),

            /// CARD INFORMASI
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
          
      ),
    );
  }
}