import 'package:flutter/material.dart';

class FajarAbdillah extends StatefulWidget {
  const FajarAbdillah({super.key});

  @override
  State<FajarAbdillah> createState() => _FajarAbdillahState();
}

class _FajarAbdillahState extends State<FajarAbdillah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fajar Abdillah",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
              elevation: 8,
              shadowColor: Colors.grey,
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue.shade400, Colors.grey.shade300],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                          width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/Fajar.jpeg"),
                            fit: BoxFit.fill
                          ),
                          border: Border.all(color: Colors.blue, width: 3),
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
                      SizedBox(height: 10),
                      Text(
                        "Fajar Abdillah",
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Hamba Allah',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
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
                              Expanded(child: Text("1123150104")),
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
                              Expanded(
                                child: Text("Laravel, Flutter, MySQL, Git"),
                              ),
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
                                  "Mengerjakan sebagian besar tampilan dan integrasi.",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}