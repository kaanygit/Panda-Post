import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pandapostdev/screens/auth_screen.dart';
import 'package:pandapostdev/screens/home.dart';
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
        initialRoute: '/',
        routes: {
          '/': (context) => AuthScreen(),
          '/home': (context) => HomeScreen(),
        });
  }
}
