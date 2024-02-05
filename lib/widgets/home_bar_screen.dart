import 'package:flutter/material.dart';
import 'package:pandapostdev/constants/constant.dart';
import 'package:pandapostdev/constants/fonts.dart';
import 'package:pandapostdev/screens/editing.dart';
import 'package:pandapostdev/screens/not_defined.dart';
import 'package:pandapostdev/services/notes_services.dart';
import 'package:pandapostdev/widgets/loading_widget.dart';

class HomeBarScreen extends StatefulWidget {
  final int activeIndex;

  const HomeBarScreen(this.activeIndex, {Key? key}) : super(key: key);

  @override
  State<HomeBarScreen> createState() => _HomeBarScreenState();
}

class _HomeBarScreenState extends State<HomeBarScreen> {
  final List<String> scrollAxisRowList = ["Work", "Important", "Flag", "To-do"];
  bool loadingBoolean = false;
  dynamic notesList = [];

  dynamic noteFlagList = [];
  dynamic noteImportantList = [];
  dynamic noteWorkList = [];
  dynamic noteTodo = [];

  final NotesServices notesServices = NotesServices();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await notesServices.fetchNotesData();
    setState(() {
      notesList = notesServices.notesList;
      for (int i = 0; i < notesList.length; i++) {
        if (notesList[i]['flag'] == true && noteFlagList.length < 5) {
          noteFlagList.add(notesList[i]);
        }
        if (notesList[i]['important'] == true && noteImportantList.length < 5) {
          noteImportantList.add(notesList[i]);
        }
        if (notesList[i]['work'] == true && noteWorkList.length < 5) {
          noteWorkList.add(notesList[i]);
        }
        if (notesList[i]['todo'] == true && noteTodo.length < 5) {
          noteTodo.add(notesList[i]);
        }
      }
      loadingBoolean = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadingBoolean
        ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //KUTULARIN BAŞLANGICI
                  if (widget.activeIndex == 1)
                    if (noteWorkList.length == 0)
                      NotDefined(0)
                    else
                      for (int i = 0; i < noteWorkList.length; i++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditingScreen(
                                                notesData: noteWorkList[i])));
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              noteWorkList[i]
                                                      ['notesTaskName'] ??
                                                  " ",
                                              style: googleFonts(
                                                20,
                                                Colors.lightGreen.shade900,
                                                FontWeight.normal,
                                              ),
                                            ),
                                            Icon(
                                              Icons.flag,
                                              color: noteWorkList[i]['flag']
                                                  ? Colors.red
                                                  : Colors.grey.shade800,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              truncateText(
                                                noteWorkList[i]['notesName'] ??
                                                    "",
                                                maxChars: 50,
                                              ),
                                              style: googleFonts(
                                                18,
                                                colorsTwo,
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              formatTimestamp(
                                                noteWorkList[i]["notesDate"],
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: noteWorkList[i]
                                                      ['important']
                                                  ? Colors.yellow
                                                  : Colors.grey.shade800,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                  else if (widget.activeIndex == 2)
                    if (noteImportantList.length == 0)
                      NotDefined(1)
                    else
                      for (int j = 0; j < noteImportantList.length; j++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditingScreen(
                                                notesData:
                                                    noteImportantList[j])));
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              noteImportantList[j]
                                                      ['notesTaskName'] ??
                                                  " ",
                                              style: googleFonts(
                                                20,
                                                Colors.lightGreen.shade900,
                                                FontWeight.normal,
                                              ),
                                            ),
                                            Icon(
                                              Icons.flag,
                                              color: noteImportantList[j]
                                                      ['flag']
                                                  ? Colors.red
                                                  : Colors.grey.shade800,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              truncateText(
                                                noteImportantList[j]
                                                        ['notesName'] ??
                                                    "",
                                                maxChars: 50,
                                              ),
                                              style: googleFonts(
                                                18,
                                                colorsTwo,
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              formatTimestamp(
                                                noteImportantList[j]
                                                    ["notesDate"],
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                  else if (widget.activeIndex == 3)
                    if (noteFlagList.length == 0)
                      NotDefined(2)
                    else
                      for (int k = 0; k < noteFlagList.length; k++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditingScreen(
                                                notesData: noteFlagList[k])));
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              noteFlagList[k]
                                                      ['notesTaskName'] ??
                                                  " ",
                                              style: googleFonts(
                                                20,
                                                Colors.lightGreen.shade900,
                                                FontWeight.normal,
                                              ),
                                            ),
                                            Icon(
                                              Icons.flag,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              truncateText(
                                                noteFlagList[k]['notesName'] ??
                                                    "",
                                                maxChars: 50,
                                              ),
                                              style: googleFonts(
                                                18,
                                                colorsTwo,
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              formatTimestamp(
                                                noteFlagList[k]["notesDate"],
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: noteFlagList[k]
                                                      ['important']
                                                  ? Colors.yellow
                                                  : Colors.grey.shade800,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                  else if (widget.activeIndex == 4)
                    if (noteTodo.length == 0)
                      NotDefined(3)
                    else
                      for (int m = 0; m < noteTodo.length; m++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("TODO VAR AMA DAHA GELMEDİ"),
                          ],
                        ),
                ],
              ),
            ),
          )
        : LoadingWidget(5, 100);
  }
}
