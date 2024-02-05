import 'package:flutter/material.dart';
import 'package:pandapostdev/constants/constant.dart';
import 'package:pandapostdev/screens/editing.dart';
import 'package:pandapostdev/screens/not_defined.dart';
import 'package:pandapostdev/services/notes_services.dart';
import 'package:pandapostdev/widgets/loading_widget.dart';

class ImportantScreen extends StatelessWidget {
  const ImportantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Important Notes'),
      ),
      body: ImportantNotes(),
    );
  }
}

class ImportantNotes extends StatefulWidget {
  const ImportantNotes({super.key});

  @override
  State<ImportantNotes> createState() => _ImportantNotesState();
}

class _ImportantNotesState extends State<ImportantNotes> {
  dynamic notesList = [];
  bool loadingBoolean = false;
  final NotesServices notesServices = NotesServices();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await notesServices.fetchNotesData();
    setState(() {
      loadingBoolean = true;
      for (int i = 0; i < notesServices.notesList.length; i++) {
        if (notesServices.notesList[i]['important'] == true) {
          notesList.add(notesServices.notesList[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loadingBoolean
            ? notesList.length != 0
                ? Column(
                    children: [
                      for (int i = 0; i < notesList.length; i++)
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  print("notes listin $i . elemanına tıkladın");
                                  if (notesList[i] != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditingScreen(
                                                  notesData: notesList[i],
                                                )));
                                  }
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(notesList[i]
                                                    ['notesTaskName'] ??
                                                ""),
                                            Icon(
                                              Icons.flag,
                                              color: notesList[i]['flag']
                                                  ? Colors.red
                                                  : Colors.grey.shade800,
                                            ),
                                          ],
                                        )),
                                    subtitle: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(truncateText(
                                            notesList[i]['notesName'] ?? "",
                                            maxChars: 75,
                                          )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    formatTimestamp(
                                                      notesList[i]["notesDate"],
                                                    ),
                                                  ),
                                                  // SizedBox(width: 4),
                                                  // Text(notesList[i]['flag']
                                                  //     ? 'Flagged'
                                                  //     : 'Not Flagged'),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: notesList[i]
                                                            ['important']
                                                        ? Colors.yellow
                                                        : Colors.grey.shade800,
                                                  ),
                                                  // SizedBox(width: 4),
                                                  // Text(notesList[i]['important']
                                                  //     ? 'Important'
                                                  //     : 'Not Important'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                    ],
                  )
                : Center(child: NotDefined(1))
            : LoadingWidget(6, 90),
      ),
    );
  }
}
