
import 'dart:collection';

import 'package:base_service_interface/base_service_interface.dart';
import 'package:base_service_interface/model/service_config.dart';

export 'package:base_service_interface/model/service_agent.dart';
export 'package:base_service_interface/model/service_config.dart';
export 'package:base_service_interface/base_service_interface.dart';

///Represents a set of services with 'master (one) - slave (many)' link
///Events from master service duplicates to slaves
abstract class BaseMultiServiceInterface<T extends BaseServiceInterface> extends BaseServiceInterface {

  ///Available 'slave 'messaging services
  HashMap<int, T> get submissiveServices;

  ///Add 'slave' service to collection with optional init config
  ///
  ///Returns service ID on collection
  Future<int?> addSubmissiveService(T service, {ServiceConfig? config});

  ///Check the 'slave' service existence by ID
  bool containsSubmissiveService(int id);

  ///Remove 'slave' service by its ID
  T? removeSubmissiveService(int id);

  ///Clear all 'slave' services
  void clearSubmissiveServices();

}
