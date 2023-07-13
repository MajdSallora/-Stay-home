

import 'package:intl/intl.dart';

extension DateConveter on DateTime {
  String toDateOnly() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(this);
    return formatted;
  }
  String toTimeOnly() {
    final DateFormat formatter = DateFormat('hh:mm');
    final String formatted = formatter.format(this);
    return formatted;
  }
}