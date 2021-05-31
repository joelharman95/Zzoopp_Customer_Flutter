import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/basics/abstract/storage_service_interface.dart';
import '../core/data/resources/api/api_interceptor.dart';
import '../core/data/resources/api/clients/login_api.dart';
import '../core/data/resources/api/rest_service.dart';
import '../core/data/resources/storage/shared_preferences_storage_service.dart';
import '../core/data/resources/storage/storage_services.dart';

Future<GetIt> $initGetIt(GetIt get, {String environment, EnvironmentFilter environmentFilter}) async {
  final getHelper = GetItHelper(get, environment, environmentFilter);

  final storageServices = _$StorageServices();

  getHelper.factory<ApiInterceptor>(() => ApiInterceptor());
  await getHelper.factoryAsync<SharedPreferences>(() => storageServices.sharedPreferences, preResolve: true);
  getHelper.factory<StorageServiceInterface>(() => storageServices.sharedPreferencesStorageService);

  getHelper.singleton<RestApi>(RestApi(get<ApiInterceptor>()));
  getHelper.singleton<LoginApi>(LoginApi(get<RestApi>()));
  return get;
}

class _$StorageServices extends StorageServices {
  @override
  SharedPreferencesStorageService get sharedPreferencesStorageService => SharedPreferencesStorageService();
}
