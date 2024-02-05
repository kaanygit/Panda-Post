import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHis => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('notes')
      .snapshots();

  void addToMeetingHistory(String meetingName, String taskName, bool flags,
      bool important, bool work) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .add({
        'notesTaskName': taskName == '' ? ' ' : taskName,
        'notesName': meetingName,
        'flag': flags,
        'important': important,
        'notesDate': DateTime.now(),
        'lastEdited': DateTime.now(),
        'work': work,
      });
    } catch (e) {
      print("Hata : $e");
    }
  }

  Future<List<Map<String, dynamic>>> getNotesDataHistory() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .get();

      List<Map<String, dynamic>> notesList = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        Map<String, dynamic> data = document.data();
        print(document.id);
        data['id'] = document.id;
        notesList.add(data);
      }

      return notesList;
    } catch (e) {
      print("Hata : $e");
      return []; // Hata durumunda boş bir liste döndür
    }
  }

  Future<void> deleteNoteFirestore(String documentId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(documentId)
          .delete();
      print("Veri başarıyla silindi");
    } catch (e) {
      print("Not silinirken bir hata oluştu : $e");
    }
  }

  Future<void> updateNoteFirestore(String newNotesName, String newTaskName,
      String documentId, bool newFlag, bool newImportant) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(documentId)
          .update({
        'notesTaskName': newNotesName,
        'notesName': newNotesName,
        'lastEdited': DateTime.now(),
        'flag': newFlag,
        'important': newImportant
      });

      print("Veri basarıyla güncellendi");
    } catch (e) {
      print("Veri Guncellenirken bir hata oluştu : $e");
    }
  }
}
