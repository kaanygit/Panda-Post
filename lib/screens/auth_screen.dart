import 'package:flutter/material.dart';
import 'package:pandapostdev/firebase/auth.dart';
import 'package:pandapostdev/screens/home.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MySplashScreen(nextScreen: AuthPage),
      home: AuthPage(),
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
