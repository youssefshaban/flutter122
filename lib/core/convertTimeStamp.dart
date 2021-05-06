// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
//
// class ConvertTimeStampToDays{
//   String readTimestamp(Timestamp timestamp) {
//     var now = new DateTime.now();
//     var format =  DateFormat('HH:mm');
//     var date = timestamp.toDate();
//     var diff = now.difference(date);
//     var time = '';
//
//     if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
//       time = format.format(date);
//     } else if (diff.inDays > 0 && diff.inDays < 7) {
//       if (diff.inDays == 1) {
//         time = diff.inDays.toString() + ' Day ago';
//       } else {
//         time = diff.inDays.toString() + ' Days ago';
//       }
//     } else {
//       if (diff.inDays == 7) {
//         time = (diff.inDays / 7).floor().toString() + ' Week ago';
//       } else {
//
//         time = (diff.inDays / 7).floor().toString() + ' Weeks ago';
//       }
//     }
//
//     return time;
//   }
// }