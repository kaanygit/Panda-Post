import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pandapostdev/constants/fonts.dart';
import 'package:pandapostdev/firebase/auth.dart';
import 'package:pandapostdev/firebase/firestore.dart';
import 'package:pandapostdev/screens/auth_screen.dart';
import 'package:pandapostdev/screens/flag.dart';
import 'package:pandapostdev/screens/important.dart';
import 'package:pandapostdev/screens/notes.dart';
import 'package:pandapostdev/screens/panda_hungry.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  GoogleSignInAccount? currentUser;
  late String username;
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = "";
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("Kullanıcı outurumu kapattı");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new AuthScreen()));
      } else {
        setState(() {
          username = user.displayName ?? '';
        });
      }
    });
    // _nameController.dispose();
  }

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect();
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appTopBar(),
      floatingActionButton: floatEditingButton(),
      backgroundColor: Colors.grey.shade200,
      drawer: burgerMenuDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/panda_two.png',
                      height: 100,
                      width: 100,
                    ),
                    Column(
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${username}",
                          style: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.lightGreen.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightGreen.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Text(
                              "Notes",
                              style: GoogleFonts.kanit(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "98",
                              style: GoogleFonts.kanit(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightGreen.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Important",
                              style: GoogleFonts.kanit(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "15",
                              style: GoogleFonts.kanit(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightGreen.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/panda_one.png',
                      width: 100,
                      height: 100,
                    ),
                    Column(
                      children: [Text("Hungry"), Text("bambu ver")],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      "Notes",
                      style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: Colors.lightGreen.shade400))),
                  ),
                  Container(
                    child: Text("Important",
                        style: GoogleFonts.kanit(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: Colors.lightGreen.shade400))),
                  ),
                  Container(
                    child: Text("Flag",
                        style: GoogleFonts.kanit(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: Colors.lightGreen.shade400))),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Task Name"),
                                  Text("saat"),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                  child: Text(
                                      "amkşsgmkşasgmkşasgmkşasgmkşasgmkşasgmkşagsmkşagsmkşasgmkşgasm")),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tarih"),
                                  Text("flag"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.lightGreen.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Task Name"),
                                  Text("saat"),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                  child: Text(
                                      "amkşsgmkşasgmkşasgmkşasgmkşasgmkşasgmkşagsmkşagsmkşasgmkşgasm")),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tarih"),
                                  Text("flag"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.lightGreen.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Task Name"),
                                        Text("sağ"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Container(
                                        child: Text(
                                            "amkşsgmkşasgmkşasgmkşasgmkşasgmkşasgmkşagsmkşagsmkşasgmkşgasm")),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tarih"),
                                        Text("sağ"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen.shade400,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ), //  adsşgmasligmaksşgşasmgkasnkgmnaskşgnkşasgnkş
          //asgşaskşgnasnkşgnşakgnkş
        ),
      ),
    );
  }

  Drawer burgerMenuDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        children: [
          DrawerHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/panda_one.png',
                  width: 120,
                  height: 120,
                ),
                Text(
                  "${username}",
                  style: googleFonts(20, Colors.black, FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Notes',
              style:
                  googleFonts(20, Colors.lightGreen.shade800, FontWeight.w600),
            ),
            onTap: () {
              print("Notes");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotesScreen()));

              // TODO: Handle item 1 press
            },
          ),
          ListTile(
            title: Text(
              'Important',
              style:
                  googleFonts(20, Colors.lightGreen.shade800, FontWeight.w600),
            ),
            onTap: () {
              print("Important");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImportantScreen()));
              // TODO: Handle item 1 press
            },
          ),
          ListTile(
            title: Text(
              'Flag',
              style:
                  googleFonts(20, Colors.lightGreen.shade800, FontWeight.w600),
            ),
            onTap: () {
              print("Flag");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FlagScreen()));
              // TODO: Handle item 1 press
            },
          ),
          ListTile(
            title: Text(
              'Panda Hungry',
              style:
                  googleFonts(20, Colors.lightGreen.shade800, FontWeight.w600),
            ),
            onTap: () {
              print("Panda Hungry");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PandaHungryScreen()));
              // TODO: Handle item 1 press
            },
          ),
          ListTile(
            title: Text(
              "Sign Out",
              style:
                  googleFonts(20, Colors.lightGreen.shade800, FontWeight.w600),
            ),
            onTap: () {
              AuthMethods().signOut();
            },
          )
        ],
      ),
    );
  }

  FloatingActionButton floatEditingButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  height: 700,
                  padding: EdgeInsets.all(20),
                  child: Column(
                      children: <Widget>[
                    TextFormField(
                      minLines: 8,
                      maxLines: null,
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter last name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: _nameController.text.length == 0
                              ? 'Enter Notes'
                              : '',
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.white10,
                          border: InputBorder.none,
                          filled: true),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.draw,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            print("Çiz butonuna basıldı");
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.list,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            print("Liste butonuna basıldı");
                          },
                        ),
                        InkWell(
                          child: Image.asset('assets/images/ai.png',
                              width: 40, height: 40),
                          onTap: () {
                            print("Yapay Zeka butonuna basıldı");
                          },
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.save_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              print("Kaydet butonuna basıldı");
                              print(_nameController.text);
                              _firestoreMethods
                                  .addToMeetingHistory(_nameController.text);
                              Navigator.pop(context);
                              _nameController.clear();
                            }),
                      ],
                    ),
                  ].reversed.toList()),
                ),
              );
            });
      },
      child: Icon(
        Icons.draw,
        color: Colors.black,
      ),
      backgroundColor: Colors.lightGreen.shade50,
    );
  }

  AppBar appTopBar() {
    return AppBar(
      title: Container(
        margin: EdgeInsets.only(right: 40),
        alignment: Alignment.center,
        child: Text(
          "Panda Post",
          style: GoogleFonts.kanit(
              fontSize: 25,
              color: Colors.lightGreen.shade800,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
