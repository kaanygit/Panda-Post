import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panda_post/screens/auth.dart';
import 'package:panda_post/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure shared prefs are ready
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  bool isAuthPage = prefs.getBool('isWelcomeScreen') ?? false;
  runApp(MyApp(isAuthPage: isAuthPage));
}

class MyApp extends StatelessWidget {
  final bool isAuthPage;

  const MyApp({Key? key, required this.isAuthPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,
        duration: const Duration(milliseconds: 5000),
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          try {
            // Hata oluşturabilecek kodlar buraya gelir
          } catch (error) {
            debugPrint("Error in onEnd: $error");
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
                  style: GoogleFonts.kanit(
                      color: Colors.lightGreen.shade800,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        nextScreen: (isAuthPage) ? const HomeScreen() : const AuthScreen(),
      ),
    );
  }
}
