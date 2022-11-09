class QosicException implements Exception {
  ///
  QosicException(
    this.msg, {
    required this.data,
  });

  ///
  String msg;

  ///
  Object data;
}
