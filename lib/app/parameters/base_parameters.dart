abstract class BaseParameter {
  final String appName;
  final String clientId;
  final String clientSecret;
  final String gmapWebKey;
  final String baseUrl;

  Flavor get flavor;

  const BaseParameter(
      {this.appName,
      this.clientId,
      this.clientSecret,
      this.gmapWebKey,
      this.baseUrl});
}

enum Flavor { development, production }
