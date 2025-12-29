import 'package:flutter/material.dart';
import 'splash_screen_4.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Spacer(),
            SizedBox(height: 50),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/icons/note.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Semua ide penting dalam satu tempat",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),

            //membuat bullet
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bullet 1
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(0xFF90CAF9),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                // Bullet 2
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(0xFF2979FF),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                // Bullet 3
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(0xFF90CAF9),
                    shape: BoxShape.circle,
                  ),
                ),
              ]
            ),
          ]
        )
        )
    );
  }
}