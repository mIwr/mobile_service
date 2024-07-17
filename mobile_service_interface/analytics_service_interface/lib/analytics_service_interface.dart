import 'package:analytics_service_interface/analytics_service_cmd_mixin.dart';
import 'package:base_service_interface/base_service_interface.dart';

export 'package:base_service_interface/model/service_agent.dart';
export 'package:base_service_interface/model/service_config.dart';
export 'package:base_service_interface/base_service_interface.dart';

///Service interface for analytics purposes
abstract class AnalyticsServiceInterface extends BaseServiceInterface with AnalyticsServiceCmdMixin {}