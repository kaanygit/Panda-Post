import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pandapostdev/constants/fonts.dart';
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
      loadingBoolean = true;
      for (int i = 0; i < notesList.length; i++) {
        if (notesList[i]['flag'] == true) {
          noteFlagList.add(notesList[i]);
        }
        if (notesList[i]['important'] == true) {
          noteImportantList.add(notesList[i]);
        }
        if (notesList[i]['work'] == true) {
          noteWorkList.add(notesList[i]);
        }
        if (notesList[i]['todo'] == true) {
          noteTodo.add(notesList[i]);
        }
      }
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          noteWorkList[i]['notesTaskName'] ??
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
                                            noteWorkList[i]['notesName'] ?? "",
                                            maxChars: 100,
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
                                          color: noteWorkList[i]['important']
                                              ? Colors.yellow
                                              : Colors.grey.shade800,
                                        ),
                                      ],
                                    ),
                                  ],
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
                                          color: noteImportantList[j]['flag']
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
                                            noteImportantList[j]['notesName'] ??
                                                "",
                                            maxChars: 100,
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
                                            noteImportantList[j]["notesDate"],
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          noteFlagList[k]['notesTaskName'] ??
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
                                            noteFlagList[k]['notesName'] ?? "",
                                            maxChars: 100,
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
                                          color: noteFlagList[k]['important']
                                              ? Colors.yellow
                                              : Colors.grey.shade800,
                                        ),
                                      ],
                                    ),
                                  ],
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

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  String truncateText(String text, {int maxChars = 30}) {
    if (text.length <= maxChars) {
      return text;
    }
    return text.substring(0, maxChars) + '...';
  }
}
