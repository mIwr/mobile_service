import 'src/errlog_service_impl.dart';
import 'package:errlog_service_interface/errlog_service_interface.dart';

export 'package:errlog_service_interface/errlog_service_interface.dart';

abstract class ErrlogService {

  static ErrlogServiceInterface? _service;

  static String get agentKey => _service?.agentKey ?? ServiceAgentExt.kGmsAgentKey;
  static ServiceAgent get agent => _service?.agent ?? ServiceAgent.gms;

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
