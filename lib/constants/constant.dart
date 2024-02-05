import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
