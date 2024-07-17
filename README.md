# Mobile services constructor

A set of interfaces that encapsulate the payload implementation of similar mobile services.
Useful for supporting several different services with single app-level implementation and plugin names (Inspired by [habr article](https://habr.com/ru/companies/friflex/articles/665686/))

## General

- Android 5.1+ (SDK 21+), supports SDK 34+
- iOS 12.0+
- Dart SDK >=3.0.0
- Flutter SDK >=3.10.0

Supported service types:

- Analytics (Firebase Analytics-like). For such plugins used the name **analytics_service**
- Error logging (Firebase Crashlytics-like). For such plugins used the name **errlog_service**
- Push messaging (Firebase FCM-like). For such plugins used the name **push_service**

Supported service variants

| Service provider   | Analytics | Error logging | Push messaging |
|--------------------|:---------:|:-------------:|:--------------:|
| Firebase (GMS)     |     +     |       +       |       +        |
| HMS                |     +     |       +       |       +        |
| Yandex App Metrica |     +     |       +       |       -        |
| Sentry             |     -     |       +       |       -        |

Supported service combinations:

- Single. Main idea - each service type contains only one service implementation. For example, use only GMS in Google Play apps, HMS - in App Gallery apps
- Prioritized single. Main idea is supporting several mobile service providers. For example, use GMS or HMS (Both providers are contained in app dependencies) on universal APK. **Notice: such combination has the same public impl with stock 'single' variant. So you can switch between these combinations without editing app sources**
- Multi (**Experimental**). Idea of such combination is using multiple services like one. Use case: DRY pattern for similar services. **Notice: such combination is incompatible with previous variants, so you need also to edit app sources in addition to pubspec.yaml**

**You can mix these combinations on your local plugin impl. For example, use GMS & HMS as prioritized single and use the result priority service as master with submissive Yandex App Metrica (Multi combination)**

## Project structure

| Structure element            | Description                                                                                                                                             |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| Mobile service interfaces    | Located at **[mobile_service_interface](./mobile_service_interface)**. Contains encapsulation interfaces for analytics, error logging and push          |
| Mobile service components    | Located at **[mobile_service_component](./mobile_service_component)**. Contains internal encapsulation implementations for public service combinations |
| GMS-only                     | Public encapsulation implementation of plugins with Google Mobile Services only: Firebase Analytics, Crashlytics and Cloud Messaging                    |
| HMS-only                     | Public encapsulation implementation of plugins with Huawei Mobile Services only: Analytics, Crash and Push                                              |
| GMS & HMS single prioritized | Public encapsulation implementation of plugins with Google and Huawei Mobile Services. GMS is *prioritized* over HMS                                    |

## Setup

1. Choose target mobile service provider: GMS, HMS, mix GMS & HMS or implement your own combination
2. Append service implementations to pubspec.yaml
```yaml
name: your_app_name
description: "App description"

# ... Before project dependencies block

# https://yaml.org/refcard.html
# Top-level anchors
repository_url: &repository_url https://github.com/mIwr/mobile_service # YAML anchor
repository_ref: &repository_ref master # YAML anchor
analytics_service_path: &analytics_service_path gms_only/analytics_service # YAML anchor
errlog_service_path: &errlog_service_path gms_only/errlog_service # YAML anchor
push_service_path: &push_service_path gms_only/push_service # YAML anchor

# ... project dependencies block

analytics_service:
  git:
    url: *repository_url
    ref: *repository_ref
    path: *analytics_service_path
errlog_service:
  git: 
    url: *repository_url 
    ref: *repository_ref
    path: *errlog_service_path
push_service:
  git:
    url: *repository_url
    ref: *repository_ref
    path: *push_service_path
```
3. Apply native platform plugin requirements, if exist (Copy Firebase google-services.json and GoogleService-Info.plist, for example)
4. Init services. The best place is main()
```dart
await AnalyticsService.instance.init();
await ErrlogService.instance.init();
```
