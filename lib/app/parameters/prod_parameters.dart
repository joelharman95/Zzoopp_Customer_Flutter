import 'base_parameters.dart';

class ProdParameter extends BaseParameter {
  // TODO set correct configuration
  const ProdParameter()
      : super(
            appName: "Zzoopp Food",
            clientId: "",
            clientSecret: "",
            gmapWebKey: "AIzaSymdsklfngwrnoiewfewonsdsgs",
            baseUrl: "https://india.store.in/api/customer/");

  @override
  Flavor get flavor => Flavor.production;
}
