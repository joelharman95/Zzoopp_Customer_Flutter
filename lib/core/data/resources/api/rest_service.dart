import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:zzoopp_food/app/locator.config.dart';
import 'package:zzoopp_food/core/basics/abstract/api_resource.dart';
import 'package:zzoopp_food/core/basics/abstract/storage_service_interface.dart';
import 'package:zzoopp_food/core/basics/enums/api_error_type.dart';
import 'package:zzoopp_food/core/data/resources/api/response/api_response.dart';
import 'package:zzoopp_food/core/data/resources/storage/storage_keys.dart';

import 'api_interceptor.dart';

@singleton
class RestApi extends ApiResource {
  static const REFRESH_TOKEN_ENDPOINT = "/v1/auth/refresh-token";
  StorageServiceInterface storageServiceInterface = locator<StorageServiceInterface>();

  ApiInterceptor _apiInterceptor;

  Dio dio = new Dio()
    ..options.followRedirects = true
    ..options.contentType = Headers.formUrlEncodedContentType;

  Dio authenticatedDio = new Dio()
    ..options.followRedirects = true
    ..options.contentType = Headers.formUrlEncodedContentType;

  RestApi(ApiInterceptor apiInterceptor) {
    authenticatedDio.interceptors.add(getInterceptor());
    dio.interceptors.add(getInterceptor());
    _apiInterceptor = apiInterceptor;
  }

  InterceptorsWrapper getInterceptor() =>
      InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        String token = await storageServiceInterface.get(StorageKey.token);
        options.headers.addAll({'Accept': 'application/json'});
        if (token != null) {
          options.headers["Authorization"] = "Bearer " + token;
        }
        return handler.next(options);
      });

  void unlockDio() {
    authenticatedDio.interceptors.responseLock.unlock();
    authenticatedDio.interceptors.requestLock.unlock();
  }

  Future<ApiResponse> get(String url,
      {Map<String, dynamic> queryParameters, CancelToken cancelToken, bool authenticated = true}) async {
    try {
      var client = authenticated ? authenticatedDio : dio;
      var response = await client.get(url, queryParameters: queryParameters, cancelToken: cancelToken);
      return this.handleResponse(response);
    } on DioError catch (error) {
      return handleError(error);
    }
  }

  Future<ApiResponse> post(String url, dynamic data,
      {CancelToken cancelToken, Map<String, dynamic> queryParameters}) async {
    try {
      var response = await authenticatedDio.post(url,
          data: data,
          queryParameters: queryParameters,
          options: Options(contentType: Headers.jsonContentType),
          cancelToken: cancelToken);

      return this.handleResponse(response);
    } on DioError catch (error) {
      return handleError(error);
    }
  }

  Future<Response> launchAuthenticatedRequestWithOptions(
      RequestOptions options) {
    return authenticatedDio.request(options.path,
        options: Options(
            headers: options.headers,
            contentType: options.contentType,
            method: options.method,
            extra: options.extra),
        queryParameters: options.queryParameters,
        data: options.data);
  }

  void _pauseRequest(int retryAfter) {
    if (retryAfter > 2) retryAfter = 2;
    authenticatedDio.interceptors.requestLock.lock();
    dio.interceptors.requestLock.lock();
    Future.delayed(Duration(minutes: retryAfter), () {
      authenticatedDio.interceptors.requestLock.unlock();
      dio.interceptors.requestLock.unlock();
    });
  }

  ApiResponse handleError(DioError error, {ApiErrorType errorCode}) {
    if (error.requestOptions.data != null) print(error.requestOptions.data);
    print(error.response);
    print(error);
    if (error.type == DioErrorType.response &&
        error.response.statusCode == 429) {
      _pauseRequest(int.parse(error.response.headers.value('retry-after') ?? '1'));
    }
    if (error.type != DioErrorType.cancel) {
      // TODO add crashlytics
      // FirebaseCrashlytics.instance
      //     .recordError(error.error, StackTrace.current)
      //     .catchError((e) => print(e));
    }
    ApiResponse errorResponse = ApiResponse(
        data: error?.response?.data,
        headers: error?.response?.headers,
        error: error,
        errorCode: errorCode,
        statusCode: error?.response.statusCode);

    this._apiInterceptor.handleErrorResponse(errorResponse);
    return errorResponse;
  }

  ApiResponse handleResponse(Response response) {
    ApiResponse apiResponse;
    if (response == null) {
      apiResponse = ApiResponse(errorCode: ApiErrorType.nullResponse, headers: response.headers);
    } else if (response.data.toString().isEmpty) {
      apiResponse = ApiResponse(data: null, headers: response.headers);
    } else {
      apiResponse = ApiResponse(data: response.data, headers: response.headers);
    }
    _apiInterceptor.handleSuccessResponse(apiResponse);
    return apiResponse;
  }
}
