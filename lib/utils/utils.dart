import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class Utility {

  // Singleton instance
  static final Utility _instance = Utility._internal();

  // Private constructor
  Utility._internal();

  // Getter to access the singleton instance
  static Utility get instance => _instance;

  // Your utility methods go here  $
  String formatAmount(double amount, {String symbol = '\₹', int decimalDigits = 2}) {
    Locale currentLocale = ui.window.locale;

    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      locale:currentLocale.toString(),
    );
    return formatter.format(amount);
  }

  double futureSipValue(double rate, double nper, double pmt) {
    double futureValue = pmt * ((pow(1 + rate, nper) - 1) / rate) * (1 + rate);
    return futureValue;
  }

}