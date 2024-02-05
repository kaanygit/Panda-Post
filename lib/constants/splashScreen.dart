import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:pandapostdev/constants/fonts.dart';

class MySplashScreen extends StatelessWidget {
  final dynamic nextScreen;
  MySplashScreen({required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      duration: const Duration(milliseconds: 3000),
      onInit: () {
        debugPrint("Splash Screen On Init");
      },
      onEnd: () {
        try {
          // hata oluşunca gönderilecek ekranımız
        } catch (e) {
          debugPrint("Error in onEnd: $e");
        }
      },
      childWidget: SizedBox(
        height: 500,
        width: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/panda_four.png',
                height: 400,
                width: 300,
              ),
              Text(
                "Panda Post",
                style: googleFonts(
                    25, Colors.lightGreen.shade800, FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      nextScreen: nextScreen,
    );
  }
}
