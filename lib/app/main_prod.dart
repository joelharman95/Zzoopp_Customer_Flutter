import 'package:zzoopp_food/app/app_config.dart';
import 'package:zzoopp_food/app/parameters/prod_parameters.dart';

import 'main.dart';

main() async {
  mainCommon(() {
    AppConfig.init(ProdParameter());
  });
}
