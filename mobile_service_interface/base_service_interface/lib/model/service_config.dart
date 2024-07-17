
///Universal service config
class ServiceConfig {
  ///API key. Used on Yandex App Metrica
  final String apiKey;
  ///Application ID. Used on Firebase
  final String? appId;
  ///Client sender ID. Used on Firebase
  final String? messagingSenderId;
  ///Service project ID. Used on Firebase
  final String? projectId;
  ///Server destination URL. Used on Sentry
  final String? dsn;

  const ServiceConfig({required this.apiKey, this.appId, this.messagingSenderId, this.projectId, this.dsn});
}