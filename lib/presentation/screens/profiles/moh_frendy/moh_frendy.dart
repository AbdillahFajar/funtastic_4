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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    infoRow("NIM", "1123150125"),
                    infoRow("Kelas", "TI 23 SE 2"),
                    infoRow(
                      "Minat",
                      "Flutter, PHP, UX Design, Git, C++",
                    ),
                    infoRow(
                      "Deskripsi",
                      "Fokus pada pengembangan aplikasi splash screen dan tampilan profile.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
          
      ),
    );
  }
  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Text(": "),
          Expanded(child: Text(value)),
           ],
      ),
    );
  }
}