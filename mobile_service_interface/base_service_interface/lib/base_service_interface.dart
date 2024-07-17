import 'package:base_service_interface/model/service_agent.dart';
import 'package:base_service_interface/model/service_config.dart';

///Base mobile service interface
abstract class BaseServiceInterface {

  ///Mobile service type agent raw key
  String get agentKey;

  ///Mobile service type agent
  ServiceAgent? get agent;

  ///Prepares service for work with default parameters and credentials (if exist)
  Future<void> init();

  ///Prepares service for work with custom init parameters and credentials (if exist)
  Future<void> initWithConfig(ServiceConfig config);
}
