import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zzoopp_food/core/basics/enums/api_error_type.dart';
import 'package:zzoopp_food/core/basics/enums/api_result_type.dart';

class ApiResponse {
  final ApiErrorType errorCode;
  final dynamic data;
  final DioError error;
  final Headers headers;
  final int statusCode;

  Map<String, dynamic> _json;
  List<Map<String, dynamic>> _jsonArray;
  ApiResultType _result;

  ApiResponse({this.data, this.error, this.errorCode, this.headers, this.statusCode}) {
    _json = data is Map ? Map<String, dynamic>.from(data) : null;
    _jsonArray = data is List ? List<Map<String, dynamic>>.from(data) : [];
    _result = error != null ||
        (_json != null &&
            (_json.containsKey('error') || _json.containsKey('errors')))
        ? ApiResultType.error
        : ApiResultType.success;
  }

  bool get succeed => _result == ApiResultType.success;

  bool get isJsonData => data is Map;

  ApiResultType get result => _result;

  Map<String, dynamic> get json => _json;

  List<Map<String, dynamic>> get jsonArray => _jsonArray;

  String get dioErrorMessage =>
      error?.message?.toString() ?? "Une erreur est survenue";

  String getFullErrorTrace() => error?.response?.toString() ?? "";

  Map<String, dynamic> get errorResponseJson =>
      error != null && error.response != null
          ? (error.response.data is String
          ? jsonDecode(error.response.data)
          : error.response.data)
          : null;

  String get errorMessage {
    Map<String, dynamic> errorJson = this.errorResponseJson;
    if (errorJson != null && errorJson.containsKey('data')) {
      List<dynamic> errors = (errorJson['data'] as Map).values.toList();

      if (errors.length > 0) {
          return errors.first;
      }
    }

    if (statusCode == 423 &&
        errorJson != null &&
        errorJson.containsKey('message')) {
      return errorJson['message'].toString();
    }
    if(statusCode == 405)
      return errorJson['message'].toString();

    return null;
  }

  bool hasErrorField(String field) {
    Map<String, dynamic> errorJson = this.errorResponseJson;
    if (errorJson != null && errorJson.containsKey('errors')) {
      return (errorJson['errors'] as Map).containsKey(field);
    }

    return false;
  }

  String get responseCode =>
      _json != null && _json.containsKey('code') ? _json['code'] : null;
}