import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:zzoopp_customer/app/locator.dart';

final locator = GetIt.instance;

@injectableInit
setupLocator() => $initGetIt(locator);
