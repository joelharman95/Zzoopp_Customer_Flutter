import 'package:flutter/material.dart';
import 'package:zzoopp_food/core/basics/enums/api_result_type.dart';

import 'api_response.dart';

class ApiPaginatedModelResponse<T> {
  final ApiResponse apiResponse;
  final List<T> models;
  final ApiPagination pagination;

  static ApiPaginatedModelResponse<T> Function(ApiResponse) handleResponse<T>(
      List<T> Function(List<Map<String, dynamic>> jsonArray) modelCreator) {
    return (ApiResponse response) {
      return ApiPaginatedModelResponse<T>(
          apiResponse: response,
          models: ApiPaginatedModelResponse.apiResponseSucceeded(response)
              ? modelCreator(
              List<Map<String, dynamic>>.from(response.json['data']))
              : null,
          pagination: ApiPagination.handleResponse(response));
    };
  }

  static bool apiResponseSucceeded(ApiResponse response) {
    return response.result == ApiResultType.success;
  }

  ApiPaginatedModelResponse(
      {@required this.apiResponse, this.pagination, List<T> models})
      : this.models = models != null ? models : <T>[];

  bool get succeeded {
    return ApiPaginatedModelResponse.apiResponseSucceeded(this.apiResponse);
  }
}

class ApiPaginatedResponse<T> {
  final ApiResponse apiResponse;
  final List<T> models;
  final ApiPagination pagination;

  static ApiPaginatedResponse<T> Function(ApiResponse) handleResponse<T>(
      List<T> Function(List<Map<String, dynamic>> json) modelCreator) {
    return (ApiResponse response) {
      return ApiPaginatedResponse<T>(
          apiResponse: response,
          models: ApiPaginatedResponse.apiResponseSucceeded(response)
              ? modelCreator(
              List<Map<String, dynamic>>.from(response.json['data']))
              : null,
          pagination: ApiPagination.handleResponse(response));
    };
  }

  static bool apiResponseSucceeded(ApiResponse response) {
    return response.result == ApiResultType.success;
  }

  ApiPaginatedResponse(
      {@required this.apiResponse, this.pagination, List<T> models})
      : this.models = models != null ? models : <T>[];

  bool get succeeded {
    return ApiPaginatedResponse.apiResponseSucceeded(this.apiResponse);
  }
}

class ApiPagination {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final String nextLink;

  const ApiPagination(
      {@required this.total,
        @required this.count,
        @required this.currentPage,
        @required this.perPage,
        @required this.totalPages,
        this.nextLink});

  static ApiPagination handleResponse(ApiResponse response) {
    return response.json != null &&
        response.json.containsKey('meta') &&
        (response.json['meta'] as Map).containsKey('pagination')
        ? ApiPagination(
      count: int.parse(
          response.json['meta']['pagination']['count'].toString()),
      total: int.parse(
          response.json['meta']['pagination']['total'].toString()),
      totalPages: int.parse(
          response.json['meta']['pagination']['total_pages'].toString()),
      currentPage: int.parse(
          response.json['meta']['pagination']['current_page'].toString()),
      perPage: int.parse(
          response.json['meta']['pagination']['per_page'].toString()),
      nextLink: Map.from(response.json['meta']['pagination']['links'])
          .containsKey('next')
          ? response.json['meta']['pagination']['links']['next']
          : null,
    )
        : null;
  }

  bool get hasNext => this.currentPage < this.totalPages;
}