import 'dart:async';
import 'dart:developer';

import 'package:qosic_dart/qosic_dart.dart';

void main(List<String> args) async {
  final qosic = QosicDart(
    moovKey: 'bencoWA5MV',
    mtnKey: 'bencoE3Z7R',
    password: 'XG6OyVWt8Lne9Mwt7cCq',
    username: 'QSUSR251',
    enableLog: true,
  );

  // await qosic
  //     .pay(
  //   network: QosicNetwork.mtn,
  //   phoneNumber: '22966478052',
  //   amount: '1',
  // )
  //     .then(
  //   (value) {
  //     Timer.periodic(const Duration(seconds: 10), (timer) async {
  //       final status = await qosic.getPaymentStatus(
  //         transferRef: value!,
  //         network: QosicNetwork.mtn,
  //         country: QosicCountry.benin,
  //       );

  //       if (status == QosicStatus.successfull || status == QosicStatus.failed) {
  //         timer.cancel();
  //         if (status == QosicStatus.successfull) {
  //           print("Success for payment");
  //         } else {
  //           print("Payment failed");
  //         }
  //       }
  //     });
  //   },
  // ).catchError(
  //   (error) {
  //     print('$error');
  //   },
  // );

  final transactionRef = await qosic.pay(
    network: QosicNetwork.mtn,
    phoneNumber: 'XXXXXXXX',

    /// precedeed by the country code. ex: 229XXXXXXXX
    amount: '1',
  );

  Timer.periodic(
    const Duration(
      seconds: 10,
    ),
    (timer) async {
      final status = await qosic.getPaymentStatus(
        transactionReference: transactionRef!,
        network: QosicNetwork.mtn,
        country: QosicCountry.benin,
      );

      if (status == QosicStatus.successfull || status == QosicStatus.failed) {
        timer.cancel();
        if (status == QosicStatus.successfull) {
          log("Success for payment");
        } else {
          log("Payment failed");
        }
      }
    },
  );
}
