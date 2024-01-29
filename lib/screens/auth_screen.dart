import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pandapostdev/firebase/auth.dart';
import 'package:pandapostdev/screens/home.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,
        duration: const Duration(milliseconds: 1000),
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
        nextScreen: FirebaseAuth.instance.currentUser == null
            ? AuthPage()
            : HomeScreen(),
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 50), // Sağdan iç boşluğu azaltıldı
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Ana eksen boyunca genişletildi
                    children: [
                      Image.asset(
                        'assets/images/panda_one.png',
                        width: 300,
                        height: 300,
                      ),
                      // SizedBox(height: 10), // İki öğe arasına boşluk eklendi
                      Center(
                        child: Text(
                          'Panda Post',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.lightGreen.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 25), // İki öğe arasına boşluk eklendi
                      Container(
                        child: Text(
                          'Capture your thoughts and ideas with our note-taking app. Organize your notes, set reminders, and stay productive!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: 50), // İki öğe arasına boşluk eklendi
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen.shade100,
                                    side: BorderSide.none),
                                onPressed: () async {
                                  bool result =
                                      await _authMethods.signInWithGoogle();
                                  if (result) {
                                    // Navigator.of(context)
                                    //     .pushReplacementNamed('/home');
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new HomeScreen()));
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Image.network(
                                      'http://pngimg.com/uploads/google/google_PNG19635.png',
                                      fit: BoxFit.cover,
                                      width: 50,
                                    )),
                                    SizedBox(
                                        width:
                                            5), // İki öğe arasına boşluk eklendi
                                    Text(
                                      "Google",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
