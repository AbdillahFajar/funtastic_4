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
              "Semua ide penting dalam satu tempat"
            )
          ]
        )
        )
    );
  }
}