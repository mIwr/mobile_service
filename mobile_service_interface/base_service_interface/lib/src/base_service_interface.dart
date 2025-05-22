
import 'model/service_agent.dart';
import 'model/service_config.dart';

///Base service interface
abstract class BaseServiceInterface {

  ///Service type agent raw key
  String get agentKey;

  ///Service type agent
  ServiceAgent? get agent;

  ///Service can be used at target platform
  bool get canUse;

  ///Prepares service for work with default parameters and credentials (if exist)
  Future<void> init();

  ///Prepares service for work with custom init parameters and credentials (if exist)
  Future<void> initWithConfig(ServiceConfig config);
}
