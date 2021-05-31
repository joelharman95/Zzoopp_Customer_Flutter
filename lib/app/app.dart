import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzoopp_food/app/app_config.dart';
import 'package:zzoopp_food/core/service/inherited_provider.dart';
import 'package:zzoopp_food/ui/styles/colors.dart';

class ZzooppApp extends StatefulWidget with WidgetsBindingObserver {
  final String initialRoute;

  ZzooppApp({Key key, this.initialRoute}) : super(key: key);

  @override
  _ZzooppAppState createState() => _ZzooppAppState();
}

class _ZzooppAppState extends State<ZzooppApp> {
  bool _initialized;
  String _initialRouteName;

  @override
  void initState() {
    _initialized = false;
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initialize() async {
    _initialRouteName = widget.initialRoute;
    _initialized = true;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ServiceProvider(
      builder: (_, serviceContainer) {
        return MaterialApp(
          title: 'Zzoopp',
          debugShowCheckedModeBanner: false,
          initialRoute: _initialRouteName,
          navigatorKey: appConfig.mainNavigatorKey,
          onGenerateRoute: appConfig.router.generateMainRoute,
          theme: ThemeData(
              primarySwatch: AppColors.primaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              bottomSheetTheme: ThemeData.light()
                  .bottomSheetTheme
                  .copyWith(backgroundColor: Colors.transparent, elevation: 0),
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppColors.primaryColor),
              ),
              fontFamily: "HelveticaNeue"),
        );
      },
    );
  }
}
