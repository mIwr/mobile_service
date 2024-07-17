import 'src/errlog_service_impl.dart';
import 'package:errlog_service_interface/errlog_service_interface.dart';

export 'package:errlog_service_interface/errlog_service_interface.dart';

abstract class ErrlogService {
  static ErrlogServiceInterface? _service;

  static String get agentKey => ServiceAgentExt.kHmsAgentKey;
  static ServiceAgent get agent => ServiceAgent.hms;

  static ErrlogServiceInterface get instance {
    var service = _service;
    if (service != null) {
      return service;
    }
    service = ErrlogServiceImpl();
    _service = service;

    return service;
  }
}