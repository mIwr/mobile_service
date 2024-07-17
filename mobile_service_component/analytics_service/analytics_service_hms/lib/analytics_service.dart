import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'src/analytics_service_impl.dart';

export 'package:analytics_service_interface/analytics_service_interface.dart';

abstract class AnalyticsService {

  static AnalyticsServiceInterface? _service;

  static String get agentKey => ServiceAgentExt.kHmsAgentKey;
  static ServiceAgent get agent => ServiceAgent.hms;

  static AnalyticsServiceInterface get instance {
    var service = _service;
    if (service != null) {
      return service;
    }
    service = AnalyticsServiceImpl();
    _service = service;

    return service;
  }
}