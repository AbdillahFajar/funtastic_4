import 'package:flutter/material.dart';
import 'package:funtastic_4/screens/splash_screen_3.dart';
// import 'splash_screen_3.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer(),
            SizedBox(height: 50),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/icons/note.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Catatan kecil, manfaat besar",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),

            //membuat bullet
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //bullet ke-1
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2979FF),
                  ),
                ),
                SizedBox(width: 10),
                //bullet ke-2
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF90CAF9),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF90CAF9),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            //bikin tombol
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen3(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD2B48C),
                    elevation: 5,
                  ),
                  child: Text(
                    "Selanjutnya",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
