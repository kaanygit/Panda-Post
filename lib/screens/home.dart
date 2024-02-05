import 'package:dotted_border/dotted_border.dart';
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
import 'package:pandapostdev/screens/work_screen.dart';
import 'package:pandapostdev/services/notes_services.dart';
import 'package:pandapostdev/widgets/home_bar_screen.dart';

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
  final TextEditingController _nameControllerTaskName = TextEditingController();
  GoogleSignInAccount? currentUser;
  late String username;
  List<Map<String, dynamic>> notesList = [];
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  late bool flagButton = false;
  final NotesServices notesServices = NotesServices();
  bool importantStartButton = false;

  final List<String> scrollAxisRowList = [
    "All",
    "Work",
    "Important",
    "Flag",
    "To-do"
  ];
  dynamic noteFlagList = 0;
  dynamic noteImportantList = 0;
  dynamic noteWorkList = 0;
  dynamic noteTodo = 0;
  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = "";
    fetchData();

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
  }

  void fetchData() async {
    await notesServices.fetchNotesData();
    setState(() {
      notesList = notesServices.notesList;
      for (int i = 0; i < notesServices.notesList.length; i++) {
        if (notesServices.notesList[i]['flag'] == true) {
          noteFlagList++;
        }
        if (notesServices.notesList[i]['important'] == true) {
          noteImportantList++;
        }
        if (notesServices.notesList[i]['work'] == true) {
          noteWorkList++;
        }
        if (notesServices.notesList[i]['todo'] == true) {
          noteTodo++;
        }
      }
      print(notesList);
    });
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
      endDrawer: burgerMenuDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < scrollAxisRowList.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            activeIndex = i;
                            HomeBarScreen(activeIndex);
                          });
                          print("${scrollAxisRowList[i]} button");
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                scrollAxisRowList[i] == "All"
                                    ? "All(${notesList.length})"
                                    : scrollAxisRowList[i],
                                style: googleFonts(
                                    20,
                                    activeIndex == i
                                        ? Colors.lightGreen.shade800
                                        : Colors.grey,
                                    FontWeight.normal),
                              ),
                              if (activeIndex == i)
                                Container(
                                    margin: EdgeInsets.only(top: 2),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 2)))),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              activeIndex < 1
                  ? Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/notes');
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: colorsThree),
                                    child: Stack(children: [
                                      Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Image.asset(
                                              "assets/images/panda_two.png",
                                              width: 150,
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "All Notes",
                                                style: googleFonts(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              )),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${notesList.length} Notes",
                                                style: googleFonts(
                                                    15,
                                                    Colors.grey.shade800,
                                                    FontWeight.normal),
                                              )),
                                        ],
                                      ),
                                    ])),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colorsOne),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/work');
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Image.asset(
                                              "assets/images/panda_three.png",
                                              width: 150,
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "Work",
                                                style: googleFonts(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              )),
                                          Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "${noteTodo} Notes",
                                                style: googleFonts(
                                                    15,
                                                    Colors.grey.shade800,
                                                    FontWeight.normal),
                                              )),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: colorsTwo),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/important');
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Important",
                                                style: googleFonts(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              ),
                                              Text(
                                                "${noteImportantList} Notes",
                                                style: googleFonts(
                                                    15,
                                                    Colors.grey.shade800,
                                                    FontWeight.normal),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        child: Image.asset(
                                          'assets/images/panda_one.png',
                                          width: 150,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DottedBorder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 50),
                                  strokeWidth: 1,
                                  color: Colors.black,
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(30),
                                  child: Stack(children: [
                                    Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.folder,
                                              size: 50,
                                              color: Colors.greenAccent,
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Add new folder",
                                              style: googleFonts(
                                                  20,
                                                  Colors.grey.shade800,
                                                  FontWeight.normal),
                                            )),
                                      ],
                                    ),
                                  ])),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colorsOne),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/todo');
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Image.asset(
                                              "assets/images/panda_three.png",
                                              width: 150,
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "To-Do",
                                                style: googleFonts(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              )),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: colorsTwo),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/flag');
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Flag",
                                                style: googleFonts(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              ),
                                              Text(
                                                "${noteFlagList} Notes",
                                                style: googleFonts(
                                                    15,
                                                    Colors.grey.shade800,
                                                    FontWeight.normal),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        child: Image.asset(
                                          'assets/images/panda_one.png',
                                          width: 150,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ))
                  : HomeBarScreen(activeIndex),
              SizedBox(
                height: 30,
              )
            ],
          ), //
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
              'Work',
              style:
                  googleFonts(20, Colors.lightGreen.shade800, FontWeight.w600),
            ),
            onTap: () {
              print("Work Screen");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WorkScreen()));
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
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.white10,
                          border: InputBorder.none,
                          filled: true),
                    ),
                    TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      controller: _nameControllerTaskName,
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: _nameControllerTaskName.text.length == 0
                              ? 'Enter Task Name'
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
                            Icons.star,
                            size: 30,
                            color: importantStartButton
                                ? Colors.yellow
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              importantStartButton = !importantStartButton;
                            });
                            print("İmportant butonuna basıldı");
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
                        InkWell(
                          child: Icon(
                            Icons.flag,
                            size: 30,
                            color: flagButton ? Colors.orange : Colors.black,
                          ),
                          onTap: () {
                            setState(() {
                              flagButton = !flagButton;
                            });
                            print("Flag button is : $flagButton");
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
                              _firestoreMethods.addToMeetingHistory(
                                  _nameController.text,
                                  _nameControllerTaskName.text,
                                  flagButton,
                                  importantStartButton,
                                  false);
                              Navigator.pop(context);
                              fetchData();
                              _nameController.clear();
                              _nameControllerTaskName.clear();
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
        alignment: Alignment.centerLeft,
        child: Text(
          "Panda Post",
          style: GoogleFonts.kanit(
              fontSize: 25,
              color: Colors.lightGreen.shade800,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
