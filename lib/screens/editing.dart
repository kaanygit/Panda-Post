import 'package:flutter/material.dart';
import 'package:pandapostdev/constants/constant.dart';
import 'package:pandapostdev/constants/fonts.dart';
import 'package:pandapostdev/firebase/firestore.dart';

class EditingScreen extends StatelessWidget {
  final dynamic notesData;

  EditingScreen({Key? key, required this.notesData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          color: Colors.white70,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
      ),
      body: EditScreenScaffold(notesData: notesData),
    );
  }
}

class EditScreenScaffold extends StatefulWidget {
  final dynamic notesData;

  EditScreenScaffold({Key? key, required this.notesData}) : super(key: key);

  @override
  State<EditScreenScaffold> createState() => _EditScreenScaffoldState();
}

class _EditScreenScaffoldState extends State<EditScreenScaffold> {
  late bool notesFieldActive = false;
  late bool notesTaskNameFieldActive = false;
  late bool flagController;
  late bool importantController;
  final TextEditingController _controllerTaskName = TextEditingController();
  final TextEditingController _controllerNotes = TextEditingController();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  @override
  void initState() {
    super.initState();
    print(widget.notesData);
    _controllerNotes.text = widget.notesData['notesName'] ?? "";
    _controllerTaskName.text = widget.notesData['notesTaskName'];
    flagController = widget.notesData['flag'];
    importantController = widget.notesData['important'];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Expanded(
                        child: TextField(
                          controller: _controllerTaskName,
                          maxLength: 50,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(border: InputBorder.none),
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              print("İŞİM BİTTİ TASK nAME İLE");
                              _firestoreMethods.updateNoteFirestore(
                                  _controllerNotes.text,
                                  _controllerTaskName.text,
                                  widget.notesData['id'],
                                  flagController,
                                  importantController);
                            });
                          },
                          style:
                              googleFonts(25, Colors.black, FontWeight.normal),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            print("important star button");
                            setState(() {
                              importantController = !importantController;
                              _firestoreMethods.updateNoteFirestore(
                                  _controllerNotes.text,
                                  _controllerTaskName.text,
                                  widget.notesData['id'],
                                  flagController,
                                  importantController);
                            });
                          },
                          icon: Icon(Icons.star),
                          color: importantController
                              ? Colors.yellow
                              : Colors.black,
                        ),
                        IconButton(
                          onPressed: () {
                            print("Flag button");
                            setState(() {
                              flagController = !flagController;
                              _firestoreMethods.updateNoteFirestore(
                                  _controllerNotes.text,
                                  _controllerTaskName.text,
                                  widget.notesData['id'],
                                  flagController,
                                  importantController);
                            });
                          },
                          icon: Icon(Icons.flag),
                          color: flagController ? Colors.red : Colors.black,
                        ),
                        IconButton(
                          onPressed: () {
                            print("clear the notes");
                            print(widget.notesData['id']);
                            _firestoreMethods
                                .deleteNoteFirestore(widget.notesData['id']);
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.delete_rounded),
                          color: Colors.green,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Last edited - ${formatTimestamp(widget.notesData['lastEdited'])}",
                  style: googleFonts(
                    13,
                    Colors.grey.shade500,
                    FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightGreen.shade200,
                  ),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: _controllerNotes,
                    maxLength: null,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    style: googleFonts(17, Colors.black, FontWeight.normal),
                    decoration: InputDecoration(border: InputBorder.none),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        print("İŞİM BİTTİ");
                        _firestoreMethods.updateNoteFirestore(
                            _controllerNotes.text,
                            _controllerTaskName.text,
                            widget.notesData['id'],
                            flagController,
                            importantController);
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
