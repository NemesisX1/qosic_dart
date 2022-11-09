// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:qosic_dart/qosic_dart.dart';
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';

const moovKey = 'xxxxxxxxxx';
const mtnKey = 'xxxxxxxxxx';
const password = 'xxxxxxxxxx';
const username = 'xxxxxxxxxx';

/// precedeed by the country code. ex: 229XXXXXXXX
const phoneNumber = 'xxxxxxxxxx';

void main() {
  group('QosicDart', () {
    test('can be instantiated', () async {
      expect(
        QosicDart(
          moovKey: '',
          mtnKey: '',
          password: '',
          username: '',
        ),
        isNotNull,
      );
    });
    group('can run', () {
      final qosic = QosicDart(
        moovKey: moovKey,
        mtnKey: mtnKey,
        password: password,
        username: username,
        enableLog: true,
      );

      test(
        'makePayment',
        () async {
          final transref = await qosic.pay(
            country: QosicCountry.benin,
            network: QosicNetwork.mtn,
            phoneNumber: phoneNumber,
            amount: '1',
          );

          print(transref);

          expect(transref, isNotNull);
        },
      );

      test(
        'makeDeposit',
        () async {
          final transref = await qosic.deposit(
            network: QosicNetwork.mtn,
            phoneNumber: phoneNumber,
            amount: '1',
          );

          expect(transref, isNotNull);
        },
      );

      test(
        'makeRefund',
        () async {
          final hasSucceed = await qosic.refund(
            network: QosicNetwork.mtn,
            transferRef: 'xxxxxxxx',
            country: QosicCountry.benin,
          );

          expect(hasSucceed, true);
        },
      );

      test(
        'getTransactionStatus',
        () async {
          final status = await qosic.getPaymentStatus(
            network: QosicNetwork.mtn,
            transferRef: 'xxxxxxxxxx',
            country: QosicCountry.benin,
          );

          expect(status, isNotNull);
        },
      );
    });
  });
}
