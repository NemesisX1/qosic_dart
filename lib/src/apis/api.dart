import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:qosic_dart/src/helpers/enums.dart';
import 'package:qosic_dart/src/helpers/exceptions.dart';
import 'package:qosic_dart/src/apis/endpoints.dart';
import 'package:qosic_dart/src/qosic_dart.dart';
import 'make_id.dart';

/// Api requests extension
extension Api on QosicDart {
  /// Compute a simple ussd payment with Qos
  ///
  /// On success return a [String] which is the id of the
  /// related payment
  Future<String?> makePayment({
    required QosicCountry country,
    required QosicNetwork network,
    required String phoneNumber,
    required String amount,
  }) async {
    final baseUrl =
        country == QosicCountry.benin ? Endpoints.bjUrl : Endpoints.tgUrl;
    String? transferRef;

    try {
      await dio.post(
        baseUrl + Endpoints.requestPayment,
        data: {
          'msisdn': phoneNumber,
          'amount': amount,
          'transref': makeID(10),
          'clientid': network == QosicNetwork.mtn ? mtnKey : moovKey
        },
      ).then((value) {
        transferRef = value.data['transref'] as String;
      });
    } on DioError catch (e) {
      if (enableLog) {
        log('An error occured on [makePayment]: $e');
      }
      throw QosicException('An error occured on [makePayment]', data: e);
    }

    return transferRef;
  }
}
