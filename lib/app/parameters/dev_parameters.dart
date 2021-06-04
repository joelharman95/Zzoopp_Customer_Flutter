import 'package:zzoopp_customer/app/parameters/base_parameters.dart';

class DevParameter extends BaseParameter {
  const DevParameter()
      : super(
            appName: "Zzoopp Food DEV",
            clientId: "",
            clientSecret: "",
            gmapWebKey: "AIzaSyDNtNt5hQpHyYe4t_0cnOw5Pd8VgtEfxdc",
            baseUrl: "https://1d1.storenxt.in/api/customer/");

  @override
  Flavor get flavor => Flavor.development;
}
