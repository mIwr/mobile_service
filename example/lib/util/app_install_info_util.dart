
import 'package:install_referrer/install_referrer.dart';

///App installation utils
abstract class AppInstallInfoUtil {

  static const String kAndroidDebugInstallSource = "DBA";
  static const String kAndroidManualInstallSource = "ANM";
  static const String kAndroidAmazonAppStoreInstallSource = "AAS";
  static const String kAndroidGooglePlayInstallSource = "GPL";
  static const String kAndroidHuaweiAppGalleryInstallSource = "HAP";
  static const String kAndroidOppoAppMarketInstallSource = "OAM";
  static const String kAndroidSamsungAppShopInstallSource = "SAS";
  static const String kAndroidVivoAppStoreInstallSource = "VAS";
  static const String kAndroidXiaomiAppStoreInstallSource = "XAS";
  static const String kIosDebugInstallSource = "DBI";
  static const String kIosTestFlightInstallSource = "TFL";
  static const String kIosAppStoreInstallSource = "IAS";

  static String getAppInstallSourceString(InstallationApp appInstallInfo) {
    switch(appInstallInfo.referrer) {
      case InstallationAppReferrer.androidDebug: return kAndroidDebugInstallSource;
      case InstallationAppReferrer.androidManually: return kAndroidManualInstallSource;
      case InstallationAppReferrer.androidAmazonAppStore: return kAndroidAmazonAppStoreInstallSource;
      case InstallationAppReferrer.androidGooglePlay: return kAndroidGooglePlayInstallSource;
      case InstallationAppReferrer.androidHuaweiAppGallery: return kAndroidHuaweiAppGalleryInstallSource;
      case InstallationAppReferrer.androidOppoAppMarket: return kAndroidOppoAppMarketInstallSource;
      case InstallationAppReferrer.androidSamsungAppShop: return kAndroidSamsungAppShopInstallSource;
      case InstallationAppReferrer.androidVivoAppStore: return kAndroidVivoAppStoreInstallSource;
      case InstallationAppReferrer.androidXiaomiAppStore: return kAndroidXiaomiAppStoreInstallSource;
      case InstallationAppReferrer.iosDebug: return kIosDebugInstallSource;
      case InstallationAppReferrer.iosTestFlight: return kIosTestFlightInstallSource;//+ Ad-hoc install
      case InstallationAppReferrer.iosAppStore: return kIosAppStoreInstallSource;
      default: return "UNS";
    }
  }
}