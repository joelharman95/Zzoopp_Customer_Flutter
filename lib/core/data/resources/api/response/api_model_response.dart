import 'package:flutter/material.dart';
import 'package:zzoopp_customer/core/basics/enums/api_result_type.dart';

import 'api_response.dart';

class ApiModelResponse<T> {
  final ApiResponse apiResponse;
  final T model;

  static ApiModelResponse<T> Function(ApiResponse) handleResponse<T>(
      T Function(Map<String, dynamic> json) modelCreator) {
    return (ApiResponse response) {
      return ApiModelResponse<T>(
          apiResponse: response,
          model: ApiModelResponse.apiResponseSucceeded(response)
              ? modelCreator(response.json['data'])
              : null);
    };
  }

  static bool apiResponseSucceeded(ApiResponse response) {
    return response.result == ApiResultType.success;
  }

  ApiModelResponse({@required this.apiResponse, this.model});

  bool get succeeded {
    return ApiModelResponse.apiResponseSucceeded(this.apiResponse);
  }
}
