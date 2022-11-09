import 'dart:math';
import 'package:qosic_dart/src/qosic_dart.dart';

/// a simple extention to add id generation function,
extension IdMaker on QosicDart {
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
}
