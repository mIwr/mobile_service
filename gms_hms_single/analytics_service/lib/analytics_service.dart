

import 'src/analytics_service_impl.dart';
import 'package:analytics_service_interface/analytics_service_interface.dart';

export 'package:analytics_service_interface/analytics_service_interface.dart';

abstract class AnalyticsService {

  static AnalyticsServiceInterface? _service;

  static String get agentKey => _service?.agentKey ?? ServiceAgentExt.kGmsAgentKey;
  static ServiceAgent get agent => _service?.agent ?? ServiceAgent.gms;

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
