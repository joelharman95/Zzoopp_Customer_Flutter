import 'package:injectable/injectable.dart';
import 'package:zzoopp_food/core/basics/typedefs/argument_callback.dart';
import 'package:zzoopp_food/core/data/resources/api/response/api_response.dart';

@injectable
class ApiInterceptor {
  List<ArgumentCallback<ApiResponse>> onError = [];
  List<ArgumentCallback<dynamic>> onSuccess = [];

  Future<void> handleErrorResponse(ApiResponse response) async =>
      this._dispatchError(response);

  Future<void> _dispatchError(ApiResponse errorResponse) async {
    this.onError.forEach((callback) {
      callback(errorResponse);
    });
  }

  Future<void> handleSuccessResponse(ApiResponse response) async =>
      this._dispatchSuccess(response);

  Future<void> _dispatchSuccess(ApiResponse successResponse) async {
    this.onSuccess.forEach((callback) {
      callback(successResponse);
    });
  }

  // Add listener to error response from request
  int addErrorListener(ArgumentCallback<ApiResponse> callback) {
    this.onError.add(callback);
    return this.onError.length - 1;
  }

  void removeErrorListener(int index) {
    this.onError.removeAt(index);
  }

  // Add listener to success response from request
  int addSuccessListener(ArgumentCallback<ApiResponse> callback) {
    this.onSuccess.add(callback);
    return this.onSuccess.length - 1;
  }

  void removeSuccessListener(int index) {
    this.onSuccess.removeAt(index);
  }
}
