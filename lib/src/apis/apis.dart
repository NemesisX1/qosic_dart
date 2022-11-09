import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:qosic_dart/src/apis/endpoints.dart';
import 'package:qosic_dart/src/apis/misc.dart';
import 'package:qosic_dart/src/helpers/enums.dart';
import 'package:qosic_dart/src/helpers/exceptions.dart';
import 'package:qosic_dart/src/qosic_dart.dart';

/// Api requests extension
extension Api on QosicDart {
  /// Compute a simple ussd payment with Qos
  ///
  /// On success return a [String] which is the id of the
  /// related payment
  Future<String?> pay({
    QosicCountry? country,
    required QosicNetwork network,
    required String phoneNumber,
    required String amount,
  }) async {
    final currentContry = country ?? getCountryFromNumber(phoneNumber);

    final baseUrl =
        currentContry == QosicCountry.benin ? Endpoints.bjUrl : Endpoints.tgUrl;

    String? transactionReference;

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
        transactionReference = value.data['transref'] as String;
      });
    } on DioError catch (e) {
      if (enableLog) {
        print(
            'An error occured on [pay]: ${e.response!.data['responsemsg'] as String}');
      }
      throw QosicException(
        'An error occured on [pay]',
        responseMsg: e.response!.data['responsemsg'] as String,
        data: e,
      );
    }

    return transactionReference;
  }

  /// Send money to the given [phoneNumber]
  Future<String?> deposit({
    required String phoneNumber,
    required String amount,
    required QosicNetwork network,
  }) async {
    final currentContry = getCountryFromNumber(phoneNumber);

    String? transactionReference;

    final baseUrl =
        currentContry == QosicCountry.benin ? Endpoints.bjUrl : Endpoints.tgUrl;

    try {
      await dio.post(
        baseUrl + Endpoints.deposit,
        data: {
          'msisdn': phoneNumber,
          'amount': amount,
          'transref': makeID(10),
          'clientid': network == QosicNetwork.mtn ? mtnKey : moovKey
        },
      ).then((value) {
        transactionReference = value.data['transref'] as String;
      });
    } on DioError catch (e) {
      if (enableLog) {
        print(
            'An error occured on [deposit]: ${e.response!.data['responsemsg'] as String}');
      }
      throw QosicException(
        'An error occured on [deposit]',
        responseMsg: e.response!.data['responsemsg'] as String,
        data: e,
      );
    }

    return transactionReference;
  }

  /// Refund user money from [transactionReference]
  ///
  /// On success it will return true
  Future<bool> refund({
    required String transactionReference,
    required QosicNetwork network,
    required QosicCountry country,
  }) async {
    final baseUrl =
        country == QosicCountry.benin ? Endpoints.bjUrl : Endpoints.tgUrl;
    // ignore: omit_local_variable_types
    bool refundHasSucceed = false;

    try {
      await dio.post(
        baseUrl + Endpoints.refund,
        data: {
          'transref': transactionReference,
          'clientid': network == QosicNetwork.mtn ? mtnKey : moovKey
        },
      ).then((value) {
        print(value);
        refundHasSucceed = true;
      });
    } on DioError catch (e) {
      if (enableLog) {
        print(
          'An error occured on [refund]: $e}',
        );
      }
      throw QosicException(
        'An error occured on [refund]',
        responseMsg: e.response!.data['responsemsg'] as String,
        data: e,
      );
    }

    return refundHasSucceed;
  }

  /// Get the current status of a transaction given its transaferRef
  Future<QosicStatus?> getPaymentStatus({
    required String transactionReference,
    required QosicNetwork network,
    required QosicCountry country,
  }) async {
    final baseUrl =
        country == QosicCountry.benin ? Endpoints.bjUrl : Endpoints.tgUrl;
    // ignore: omit_local_variable_types
    QosicStatus? status;
    try {
      await dio.post(
        baseUrl + Endpoints.getTransactionsStatus,
        data: {
          'transref': transactionReference,
          'clientid': network == QosicNetwork.mtn ? mtnKey : moovKey
        },
      ).then((value) {
        switch (value.data['responsemsg'] as String) {
          case 'SUCCESSFUL':
            status = QosicStatus.successfull;
            break;
          case 'PENDING':
            status = QosicStatus.pending;
            break;
          case 'FAILED':
            status = QosicStatus.failed;
            break;
          default:
        }
      });
    } on DioError catch (e) {
      if (enableLog) {
        print(
          'An error occured on [getPaymentStatus]: $e}',
        );
      }
      throw QosicException(
        'An error occured on [getPaymentStatus]',
        responseMsg: e.response!.data['responsemsg'] as String,
        data: e,
      );
    }

    return status;
  }
}
