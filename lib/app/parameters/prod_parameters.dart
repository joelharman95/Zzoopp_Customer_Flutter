import 'base_parameters.dart';

class ProdParameter extends BaseParameter {
  // TODO set correct configuration
  const ProdParameter()
      : super(
            appName: "Zzoopp Food",
            clientId: "",
            clientSecret: "",
            gmapWebKey: "AIzaSyDNtNt5hQpHyYe4t_0cnOw5Pd8VgtEfxdc",
            baseUrl: "https://1d1.storenxt.in/api/customer/");

  @override
  Flavor get flavor => Flavor.production;
}
