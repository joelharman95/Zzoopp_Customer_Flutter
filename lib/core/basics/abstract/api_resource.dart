import 'package:zzoopp_customer/app/app_config.dart';

abstract class ApiResource {
  String get baseUrl => appConfig.parameters.baseUrl;
  String getUrl(String path) => this.baseUrl + path;
}
