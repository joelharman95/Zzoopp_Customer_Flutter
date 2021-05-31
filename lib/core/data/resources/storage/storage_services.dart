import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zzoopp_food/core/basics/abstract/storage_service_interface.dart';
import 'package:zzoopp_food/core/data/resources/storage/shared_preferences_storage_service.dart';

@module
abstract class StorageServices {
  @preResolve
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @Injectable(as: StorageServiceInterface)
  SharedPreferencesStorageService get sharedPreferencesStorageService;
}
