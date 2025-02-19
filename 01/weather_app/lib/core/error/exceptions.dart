import 'package:weather_app/core/network/api_error_msg_model.dart';

class ServerException implements Exception {
  final ApiErrorMsgModel apiErrorMsg;
  ServerException(this.apiErrorMsg);
}
