import 'package:equatable/equatable.dart';

class ApiErrorMsgModel extends Equatable {
  final int statusCode;
  final String statusMsg;
  final bool success;
  const ApiErrorMsgModel({
    required this.statusCode,
    required this.statusMsg,
    required this.success,
  });

  factory ApiErrorMsgModel.fromJson(Map<String, dynamic> map) {
    return ApiErrorMsgModel(
      statusCode: map['status_code'] as int,
      statusMsg: map['status_message'] as String,
      success: map['success'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status_code': statusCode,
      'status_message': statusMsg,
      'success': success,
    };
  }

  @override
  List<Object> get props => [statusCode, statusMsg, success];
}
