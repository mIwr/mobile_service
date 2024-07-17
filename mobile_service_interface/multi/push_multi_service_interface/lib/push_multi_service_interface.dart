
import 'dart:async';

import 'package:base_multi_service_interface/base_multi_service_interface.dart';
import 'package:push_service_interface/model/ps_remote_message.dart';
import 'package:push_service_interface/push_service_cmd_mixin.dart';
import 'package:push_service_interface/push_service_interface.dart';

export 'package:push_service_interface/push_service_interface.dart';
export 'package:base_multi_service_interface/base_multi_service_interface.dart';
export 'package:push_service_interface/model/ps_remote_message.dart';

abstract class PushMultiServiceInterface extends BaseMultiServiceInterface<PushServiceInterface> with PushServiceCmdMixin {

  static StreamController<PSRemoteMessage> get onMessageEventsController => PushServiceInterface.onMessageEventsController;

  static StreamController<PSRemoteMessage> get onMessageOpenedAppEventsController => PushServiceInterface.onMessageOpenedAppEventsController;

}
