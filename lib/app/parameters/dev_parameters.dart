import 'package:zzoopp_food/app/parameters/base_parameters.dart';

class DevParameter extends BaseParameter {
  const DevParameter()
      : super(
            appName: "Zzoopp Food DEV",
            clientId: "",
            clientSecret: "",
            gmapWebKey: "AIzaSyC0_qlfTtQXCqDJkM7prmZXljV78aZ-UZY",
            baseUrl: "https://1d1.storenxt.in/api/customer/");

  @override
  Flavor get flavor => Flavor.development;
}
