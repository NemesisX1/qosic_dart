import 'dart:math';
import 'package:qosic_dart/src/helpers/enums.dart';
import 'package:qosic_dart/src/qosic_dart.dart';

/// a simple extention to add id generation function,
extension Misc on QosicDart {
  /// generate a random string
  String makeID(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }

  /// get the current [QosicCountry] from the phone
  QosicCountry getCountryFromNumber(String phone) {
    final contryCode = phone.substring(0, 2);
    switch (contryCode) {
      case '228':
        return QosicCountry.togo;
      case '229':
        return QosicCountry.benin;
      case '234':
        return QosicCountry.nigeria;
      default:
        return QosicCountry.benin;
    }
  }
}
