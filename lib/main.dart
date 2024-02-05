import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pandapostdev/constants/splashScreen.dart';
import 'package:pandapostdev/screens/auth_screen.dart';
import 'package:pandapostdev/screens/editing.dart';
import 'package:pandapostdev/screens/flag.dart';
import 'package:pandapostdev/screens/home.dart';
import 'package:pandapostdev/screens/important.dart';
import 'package:pandapostdev/screens/notes.dart';
import 'package:pandapostdev/screens/panda_hungry.dart';
import 'package:pandapostdev/screens/todo_screen.dart';
import 'package:pandapostdev/screens/work_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure shared prefs are ready
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      home: MySplashScreen(
        nextScreen: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              print("Hata: ${snapshot.error}");
              return Scaffold(
                body: Center(
                  child: Text(
                      "Bir hata oluştu. Detaylar için debug console'u kontrol edin."),
                ),
              );
            } else {
              return AuthScreen();
            }
          },
        ),
      ),
      routes: {
        '/notes': (context) => NotesScreen(),
        '/important': (context) => ImportantScreen(),
        '/flag': (context) => FlagScreen(),
        // '/pandahungry': (context) => PandaHungryScreen(),
        '/work': (context) => WorkScreen(),
        '/todo': (context) => TodoScreen(),
        '/editing': (context, {arguments}) =>
            EditingScreen(notesData: arguments),
      },
    );
  }
}
