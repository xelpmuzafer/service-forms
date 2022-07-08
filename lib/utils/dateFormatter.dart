// ignore_for_file: file_names, depend_on_referenced_packages
// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '-');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('-', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

String formatTimeOfDay(DateTime now) {
    
    final dt = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
}