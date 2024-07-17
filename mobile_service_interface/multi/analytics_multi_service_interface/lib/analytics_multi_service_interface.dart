
import 'package:analytics_service_interface/analytics_service_cmd_mixin.dart';
import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'package:base_multi_service_interface/base_multi_service_interface.dart';

export 'package:analytics_service_interface/analytics_service_interface.dart';
export 'package:base_multi_service_interface/base_multi_service_interface.dart';

abstract class AnalyticsMultiServiceInterface extends BaseMultiServiceInterface<AnalyticsServiceInterface> with AnalyticsServiceCmdMixin {}
