import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zzoopp_customer/app/app.dart';
import 'package:zzoopp_customer/app/locator.config.dart';
import 'package:zzoopp_customer/app/routes/routes.dart';
import 'package:zzoopp_customer/core/basics/abstract/storage_service_interface.dart';
import 'package:zzoopp_customer/core/data/resources/storage/storage_keys.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';

void mainCommon(Function() initializeEnvironmentVariables) {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));
    await initializeEnvironmentVariables();

    // Initializing firebase
    await Firebase.initializeApp();
    // Initializing dependencies
    await setupLocator();
    // await appConfig.checkInstallationId();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Running app
    String initialRoute = await getInitialRoute();
    runApp(ZzooppApp(
      initialRoute: initialRoute,
    ));
  }, (error, stack) {
    print("GET_______ERROR______" + error.toString());
  });

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
  }).sendPort);
}

Future<String> getInitialRoute() async {
  StorageServiceInterface storageServiceInterface = locator<StorageServiceInterface>();
  String token = await storageServiceInterface.get(StorageKey.token);
  String isTutorial = await storageServiceInterface.get(StorageKey.isTutorial);
  String initialRoute;
  if (token == null) {
    if (isTutorial == null) {
      // initialRoute = Routes.tutorial;
      initialRoute = Routes.login;
    } else {
      initialRoute = Routes.login;
    }
  } else {
    initialRoute = Routes.login;
    // initialRoute = Routes.home;
  }
  return initialRoute;
}
