import 'dart:async';
import 'dart:developer';

import 'package:qosic_dart/qosic_dart.dart';

void main(List<String> args) async {
  final qosic = QosicDart(
    moovKey: 'XXXXXXXX',
    mtnKey: 'XXXXXXXX',
    password: 'XXXXXXXX',
    username: 'XXXXXXXX',
  );

  await qosic
      .pay(
    network: QosicNetwork.mtn,
    phoneNumber: 'XXXXXXXX',
    amount: '1',
  )
      .then(
    (value) {
      Timer.periodic(const Duration(seconds: 10), (timer) async {
        final status = await qosic.getPaymentStatus(
          transactionReference: value!,
          network: QosicNetwork.mtn,
          country: QosicCountry.benin,
        );

        if (status == QosicStatus.successfull || status == QosicStatus.failed) {
          timer.cancel();
          if (status == QosicStatus.successfull) {
            print("Success for payment");
          } else {
            print("Payment failed");
          }
        }
      });
    },
  ).catchError(
    (error) {
      print('$error');
    },
  );
}
