import 'package:zzoopp_customer/app/parameters/base_parameters.dart';

class DevParameter extends BaseParameter {
  const DevParameter()
      : super(
            appName: "Zzoopp Food DEV",
            clientId: "",
            clientSecret: "",
            gmapWebKey: "AIzaSymdsklfngwrnoiewfewonsdsgs",
            baseUrl: "https://india.store.in/api/customer/");

  @override
  Flavor get flavor => Flavor.development;
}
