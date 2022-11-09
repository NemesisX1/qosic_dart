class QosicException implements Exception {
  ///
  QosicException(
    this.msg, {
    this.responseMsg,
    required this.data,
  });

  ///
  String msg;

  ///
  Object data;

  ///
  String? responseMsg;
}
