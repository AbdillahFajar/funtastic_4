import 'package:flutter/material.dart';

class DamarBagas extends StatelessWidget {
  const DamarBagas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Damar Bagas ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
                height: 350,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/Damar.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      "NIM",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(" : "),
                  Expanded(child: Text("1123150107")),
                ],
              ),

              SizedBox(height: 6),

              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      "Kelas",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(" : "),
                  Expanded(child: Text("TI 23 SE 2")),
                ],
              ),

              SizedBox(height: 6),

              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      "Minat/Keahlian",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(" : "),
                  Expanded(child: Text("PBO")),
                ],
              ),

              SizedBox(height: 6),

              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      "Deskripsi",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(" : "),
                  Expanded(
                    child: Text(
                      "Mengerjakan splash screen, tampilan tim. tampilan profile,",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
