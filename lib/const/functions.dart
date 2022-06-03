import 'package:intl/intl.dart';

bool intToBool(input) {
  if (input == 0) {
    return false;
  } else {
    return true;
  }
}

DateFormat formatter = DateFormat('yyyy-MM-dd');
DateFormat timeFormatter = DateFormat.jm();

int boolToIntConverter(bool input) {
  if (input) {
    return 1;
  } else {
    return 0;
  }
}
