import 'package:flutter/material.dart';
import 'package:panda_post/constants/fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isChecked = false;
  bool _isSign = false;
  bool _isVisibil = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isSign ? signUpPage() : signInPage(),
    );
  }

  SingleChildScrollView signUpPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 50, horizontal: 50), // Sağdan iç boşluğu azaltıldı
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Ana eksen boyunca genişletildi
            children: [
              Image.asset(
                'assets/images/panda_one.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.lightGreen.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10), // İki öğe arasına boşluk eklendi
              Container(
                child: Text(
                  'Capture your thoughts and ideas with our note-taking app. Organize your notes, set reminders, and stay productive!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 10), // İki öğe arasına boşluk eklendi
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.lightGreen.shade100,
                          side: BorderSide.none),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            fit: BoxFit.cover,
                            width: 30,
                          )),
                          SizedBox(width: 5), // İki öğe arasına boşluk eklendi
                          Text(
                            "Google",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text("Or"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              Column(
                children: [
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // İki öğe arasına boşluk eklendi
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // İki öğe arasına boşluk eklendi
                  TextField(
                    maxLines: 1,
                    obscureText: (_isVisibil) ? false : true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: OutlinedButton(
                        child: (_isVisibil)
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            visualDensity: VisualDensity.compact,
                            elevation: 0),
                        onPressed: () {
                          _isVisibility();
                        },
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // İki öğe arasına boşluk eklendi
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          _onChecked(value);
                        },
                      ),
                      SizedBox(width: 5), // İki öğe arasına boşluk eklendi
                      Flexible(
                        child: Text(
                          "I’m agree to The Tarms of Service and Privasy Policy",
                          style: googleFonts(
                              12, Colors.grey.shade800, FontWeight.normal),
                          overflow: TextOverflow
                              .visible, // Taşma durumunda metnin görünmesini sağlar
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                child: Text(
                  "Create Account",
                  style: googleFonts(15, Colors.white, FontWeight.normal),
                ),
              ),
              SizedBox(height: 10), // İki öğe arasına boşluk eklendi
              Row(
                children: [
                  Text(
                    "Do you have an account?",
                    style: googleFonts(
                        12, Colors.grey.shade800, FontWeight.normal),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isSignChange();
                        });
                      },
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      child: Text(
                        "Sign In",
                        style: googleFonts(
                            12, Colors.lightGreen.shade900, FontWeight.normal),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView signInPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 50, horizontal: 50), // Sağdan iç boşluğu azaltıldı
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Ana eksen boyunca genişletildi
            children: [
              Image.asset(
                'assets/images/panda_one.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.lightGreen.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10), // İki öğe arasına boşluk eklendi
              Container(
                child: Text(
                  'Capture your thoughts and ideas with our note-taking app. Organize your notes, set reminders, and stay productive!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 10), // İki öğe arasına boşluk eklendi
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.lightGreen.shade100,
                          side: BorderSide.none),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            fit: BoxFit.cover,
                            width: 30,
                          )),
                          SizedBox(width: 5), // İki öğe arasına boşluk eklendi
                          Text(
                            "Google",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text("Or"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              Column(
                children: [
                  SizedBox(height: 10), // İki öğe arasına boşluk eklendi
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // İki öğe arasına boşluk eklendi
                  TextField(
                    maxLines: 1,
                    obscureText: (_isVisibil) ? false : true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: OutlinedButton(
                        child: (_isVisibil)
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            visualDensity: VisualDensity.compact,
                            elevation: 0),
                        onPressed: () {
                          _isVisibility();
                        },
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(side: BorderSide.none),
                        child: Text(
                          "Forgot Password?",
                          style: googleFonts(
                              12, Colors.grey.shade800, FontWeight.normal),
                          overflow: TextOverflow
                              .visible, // Taşma durumunda metnin görünmesini sağlar
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20), // İki öğe arasına boşluk eklendi
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                child: Text(
                  "Log In",
                  style: googleFonts(15, Colors.white, FontWeight.normal),
                ),
              ),
              SizedBox(height: 10), // İki öğe arasına boşluk eklendi
              Row(
                children: [
                  Text(
                    "Don’t have account?",
                    style: googleFonts(
                        12, Colors.grey.shade800, FontWeight.normal),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isSignChange();
                        });
                      },
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      child: Text(
                        "Sign Up",
                        style: googleFonts(
                            12, Colors.lightGreen.shade900, FontWeight.normal),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChecked(bool? value) {
    if (value != null) {
      setState(() {
        _isChecked = value;
      });
    }
  }

  void _isSignChange() {
    setState(() {
      _isSign = !_isSign;
      _isVisibil = false;
    });
    print(_isSign);
  }

  void _isVisibility() {
    setState(() {
      _isVisibil = !_isVisibil;
    });
  }
}
