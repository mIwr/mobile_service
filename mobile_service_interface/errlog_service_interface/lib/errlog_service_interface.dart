import 'package:base_service_interface/base_service_interface.dart';
import 'package:errlog_service_interface/errlog_service_cmd_mixin.dart';

export 'package:base_service_interface/model/service_agent.dart';
export 'package:base_service_interface/model/service_config.dart';
export 'package:base_service_interface/base_service_interface.dart';

///Service interface for error logging purposes
abstract class ErrlogServiceInterface extends BaseServiceInterface with ErrlogServiceCmdMixin {}