// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:pandapostdev/services/notes_services.dart';
// import 'package:pandapostdev/widgets/loading_widget.dart';

// class NotesData extends StatefulWidget {
//   const NotesData({Key? key}) : super(key: key);

//   @override
//   State<NotesData> createState() => _NotesDataState();
// }

// class _NotesDataState extends State<NotesData> {
//   dynamic notesList = [];
//   bool loadingBoolean = false;
//   final NotesServices notesServices = NotesServices();
//   int maxNotesToShow =
//       3; // Burada kaç nota kadar göstermek istediğinizi belirtin

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     printsate();
//   }

//   void fetchData() async {
//     await notesServices.fetchNotesData();
//     // Burada verilere erişebilirsiniz
//     print(notesServices.notesList);
//     setState(() {
//       notesList = notesServices.notesList;
//       loadingBoolean = true;
//     });
//   }

//   void printsate() {
// //debug ekranına printle tektek hepsini
//     print(notesList[2]["notesTaskName"]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loadingBoolean
//         ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               for (int i = 0; i < notesList.length && i < maxNotesToShow; i++)
//                 Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           child: Column(
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(notesList[i]['notesTaskName'] ?? " "),
//                                   Text("saat"),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 7,
//                               ),
//                               Container(
//                                 child: Text(
//                                   notesList[i]["notesName"] ?? " Not",
//                                   // Diğer alanları buraya ekleyin
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 7,
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(timeCalenderCalculate(notesList[i][seconds],notesList[i][nanoseconds])),
//                                   Icon(
//                                     Icons.flag,
//                                     size: 20,
//                                     color: notesList[i]["flag"]
//                                         ? Colors.orange
//                                         : Colors.white,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             color: Colors.lightGreen.shade400,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       )
//                     ],
//                   ),
//                 ),
//               if (notesList.length > maxNotesToShow)
//                 Text("Ve daha fazla not var..."),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     printsate();
//                   },
//                   child: Text("bas"))
//             ],
//           )
//         : Column(
//             children: [
//               LoadingWidget(),
//               LoadingWidget(),
//               LoadingWidget(),
//             ],
//           );
//   }

//   String formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pandapostdev/services/notes_services.dart';
import 'package:pandapostdev/widgets/loading_widget.dart';

class NotesData extends StatefulWidget {
  const NotesData({Key? key}) : super(key: key);

  @override
  State<NotesData> createState() => _NotesDataState();
}

class _NotesDataState extends State<NotesData> {
  dynamic notesList = [];
  bool loadingBoolean = false;
  final NotesServices notesServices = NotesServices();
  int maxNotesToShow = 3;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadingBoolean
        ? notesList.length > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i < notesList.length && i < maxNotesToShow;
                      i++)
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
                                      Text(
                                          notesList[i]['notesTaskName'] ?? " "),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    child: Text(
                                      notesList[i]["notesName"] ?? " Not",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatTimestamp(
                                            notesList[i]["notesDate"]),
                                      ),
                                      Icon(
                                        Icons.flag,
                                        size: 20,
                                        color: notesList[i]["flag"]
                                            ? Colors.orange
                                            : Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen.shade400,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  if (notesList.length > maxNotesToShow)
                    Text("Ve daha fazla not var..."),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            : Container(
                child: Text("hiçbir ürün yok"),
              )
        : Column(
            children: [
              LoadingWidget(3, 100),
            ],
          );
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  void printsate() {
    print(notesList[2]["notesTaskName"]);
  }
}
