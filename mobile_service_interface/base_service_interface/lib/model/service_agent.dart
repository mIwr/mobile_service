
///Predefined mobile service agent type
enum ServiceAgent {
  ///Google Mobile Services (GMS)
  gms,
  ///Huawei Mobile Services (HMS)
  hms,
  ///Yandex App Metrica
  yandexAppMetrica,
  ///Sentry
  sentry
}

extension ServiceAgentExt on ServiceAgent {

  static const kGmsAgentKey = "gms";
  static const kHmsAgentKey = "hms";
  static const kYandexAppMetricaAgentKey = "appMetrica";
  static const kSentryAgentKey = "sentry";

  ///Parse service agent from raw key
  static ServiceAgent? from(String key) {
    switch(key) {
      case kGmsAgentKey: return ServiceAgent.gms;
      case kHmsAgentKey: return ServiceAgent.hms;
      case kYandexAppMetricaAgentKey: return ServiceAgent.yandexAppMetrica;
      case kSentryAgentKey: return ServiceAgent.sentry;
    }
    return null;
  }

  ///Service agent type raw key
  String get key {
    switch (this) {
      case ServiceAgent.gms: return kGmsAgentKey;
      case ServiceAgent.hms: return kHmsAgentKey;
      case ServiceAgent.yandexAppMetrica: return kYandexAppMetricaAgentKey;
      case ServiceAgent.sentry: return kSentryAgentKey;
    }
  }
}