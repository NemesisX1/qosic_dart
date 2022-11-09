// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:qosic_dart/src/apis/endpoints.dart';

/// {@template qosic_dart}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class QosicDart {
  /// {@macro qosic_dart}
  QosicDart({
    required this.moovKey,
    required this.mtnKey,
    required this.password,
    required this.username,
    this.enableLog = false,
  });

  /// mtn private key
  final String mtnKey;

  /// moov private key
  final String moovKey;

  /// api username
  final String username;

  /// api password
  final String password;

  /// a [bool] to know if you want to load with debug log
  final bool enableLog;

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ' +
            base64.encode(
              utf8.encode('$username:$password'),
            )
      },
    ),
  );
}
