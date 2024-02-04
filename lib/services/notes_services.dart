import 'package:pandapostdev/firebase/firestore.dart';
import 'package:pandapostdev/models/notes_model.dart';

class NotesServices {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  List<Map<String, dynamic>> notesList = [];

  Future<List<NotesModel>> getNotes() async {
    await fetchNotesData();

    // notesList verilerini kullanarak NotesModel listesini oluşturun
    List<NotesModel> notes = notesList.map((noteData) {
      return NotesModel.fromMap(noteData);
    }).toList();

    return notes;
  }

  Future<void> fetchNotesData() async {
    List<Map<String, dynamic>> result =
        await _firestoreMethods.getNotesDataHistory();
    notesList = result;
  }
}
