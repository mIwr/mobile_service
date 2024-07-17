import 'package:errlog_service_interface/errlog_service_cmd_mixin.dart';
import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:base_multi_service_interface/base_multi_service_interface.dart';

export 'package:errlog_service_interface/errlog_service_interface.dart';
export 'package:base_multi_service_interface/base_multi_service_interface.dart';

abstract class ErrlogMultiServiceInterface extends BaseMultiServiceInterface<ErrlogServiceInterface> with ErrlogServiceCmdMixin {}