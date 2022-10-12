import 'package:intl/intl.dart';

class Utils {
  static String getCurrency(double? idr, {bool isNegative = false}) {
    if (idr != null) {
      final currency = NumberFormat("###,###.###", "ID").format(idr);
      return 'Rp ${isNegative ? "-" : ""}$currency';
    }
    return 'Rp 0';
  }

  static String dateFormatddMMMyyyy(DateTime? date) {
    if (date != null)
      return DateFormat(
        'dd MMM yyyy',
        'id_ID',
      ).format(date);
    return '';
  }

  static String dateHour(DateTime? hour) {
    if (hour != null)
      return DateFormat(
        'HH:mm',
      ).format(hour);
    return '';
  }
}