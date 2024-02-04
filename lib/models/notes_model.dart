import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String notesTaskName;
  final String notesName;
  final Timestamp notesDate;
  final bool flag;
  final bool important;

  NotesModel({
    required this.notesTaskName,
    required this.notesName,
    required this.notesDate,
    required this.flag,
    required this.important,
  });

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
        notesName: map['notesName'] ?? '',
        notesTaskName: map['notesTaskName'] ?? '',
        notesDate: map['notesDate'] ?? Timestamp.now(),
        flag: map['flag'] ?? false,
        important: map['important'] ?? false);
  }
}
