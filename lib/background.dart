import 'package:flutter/material.dart';
const String imgAndorid = "assets/android_robot.png";
class BackgroundMainEnployee extends StatelessWidget {
  const BackgroundMainEnployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgAndorid),
                  fit: BoxFit.contain
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Your name, test',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white54
              ), 
            ),
          ],
        ),
      ),
    );
  }
}