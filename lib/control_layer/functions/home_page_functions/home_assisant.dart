//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:intl/intl.dart';

//-------------------------- InStore App Imports ----------------------------------

class HomeAssistant {
  HomeAssistant._();

  static List getMediaList(List listOfMaps, String whatToGet) {
// simple example
    // final listOfMaps = [
    //   {'id': 1, 'name': 'flutter', 'title': 'dart'},
    //   {'id': 35, 'name': 'flutter', 'title': 'dart'},
    //   {'id': 93, 'name': 'flutter', 'title': 'dart'},
    //   {'id': 82, 'name': 'flutter', 'title': 'dart'},
    //   {'id': 28, 'name': 'flutter', 'title': 'dart'},
    // ];

    final listOfUrlStrings = listOfMaps
        .map((item) => item[whatToGet])
        .toList(); // for example [1, 35, 93, 82, 28]
    return listOfUrlStrings;
  }

  static bool getIsOverflow({
    required String? text,
    required int maxLength,
  }) {
    if (text == null) {
      return false;
    } else if (text.length <= maxLength) {
      return false;
    } else {
      return true;
    }
  }

  static String putCommaInThousands({required int number}) {
    var formatter = NumberFormat.decimalPattern();
    return formatter.format(number).toString();
  }

  static String replaceDotAtEnd({required String text}) {
    if (text.endsWith(".")) {
      text = text.split(".")[0];
    }
    return "$text: ";
  }

  static String formateTime({required String timeString}) {
    DateTime time = DateTime.parse(timeString);
    return DateFormat.yMMMEd().addPattern(",").add_jm().format(time);
  }
}
