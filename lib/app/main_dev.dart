import 'package:zzoopp_customer/app/app_config.dart';
import 'package:zzoopp_customer/app/parameters/dev_parameters.dart';

import 'main.dart';

main() async {
  mainCommon(() {
    AppConfig.init(DevParameter());
  });
}
