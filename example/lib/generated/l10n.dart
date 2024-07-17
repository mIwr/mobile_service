// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Errlog`
  String get tab_errlog_name {
    return Intl.message(
      'Errlog',
      name: 'tab_errlog_name',
      desc: '',
      args: [],
    );
  }

  /// `Push`
  String get tab_push_name {
    return Intl.message(
      'Push',
      name: 'tab_push_name',
      desc: '',
      args: [],
    );
  }

  /// `Analytics collection`
  String get analytics_collection {
    return Intl.message(
      'Analytics collection',
      name: 'analytics_collection',
      desc: '',
      args: [],
    );
  }

  /// `Send event`
  String get analytics_send_event {
    return Intl.message(
      'Send event',
      name: 'analytics_send_event',
      desc: '',
      args: [],
    );
  }

  /// `Navigation logging`
  String get analytics_route_log {
    return Intl.message(
      'Navigation logging',
      name: 'analytics_route_log',
      desc: '',
      args: [],
    );
  }

  /// `Navigation between screens logging`
  String get analytics_route_log_title {
    return Intl.message(
      'Navigation between screens logging',
      name: 'analytics_route_log_title',
      desc: '',
      args: [],
    );
  }

  /// `Error logging`
  String get errlog_collection {
    return Intl.message(
      'Error logging',
      name: 'errlog_collection',
      desc: '',
      args: [],
    );
  }

  /// `Simulate error`
  String get errlog_simulate_err {
    return Intl.message(
      'Simulate error',
      name: 'errlog_simulate_err',
      desc: '',
      args: [],
    );
  }

  /// `Refresh token`
  String get push_refresh_token {
    return Intl.message(
      'Refresh token',
      name: 'push_refresh_token',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get general_minute_short {
    return Intl.message(
      'min',
      name: 'general_minute_short',
      desc: '',
      args: [],
    );
  }

  /// `sec`
  String get general_second_short {
    return Intl.message(
      'sec',
      name: 'general_second_short',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get general_info {
    return Intl.message(
      'Info',
      name: 'general_info',
      desc: '',
      args: [],
    );
  }

  /// `General info`
  String get general_gen_info {
    return Intl.message(
      'General info',
      name: 'general_gen_info',
      desc: '',
      args: [],
    );
  }

  /// `Additional info`
  String get general_additional_info {
    return Intl.message(
      'Additional info',
      name: 'general_additional_info',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get general_all {
    return Intl.message(
      'All',
      name: 'general_all',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get general_search {
    return Intl.message(
      'Search',
      name: 'general_search',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get general_date {
    return Intl.message(
      'Date',
      name: 'general_date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get general_time {
    return Intl.message(
      'Time',
      name: 'general_time',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get general_today {
    return Intl.message(
      'Today',
      name: 'general_today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get general_tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'general_tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get general_add {
    return Intl.message(
      'Add',
      name: 'general_add',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get general_send {
    return Intl.message(
      'Send',
      name: 'general_send',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get general_delete {
    return Intl.message(
      'Delete',
      name: 'general_delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get general_cancel {
    return Intl.message(
      'Cancel',
      name: 'general_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get general_cancel_action {
    return Intl.message(
      'Cancel',
      name: 'general_cancel_action',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get general_close {
    return Intl.message(
      'Close',
      name: 'general_close',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get general_next {
    return Intl.message(
      'Next',
      name: 'general_next',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get general_confirm {
    return Intl.message(
      'Confirm',
      name: 'general_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get general_choose {
    return Intl.message(
      'Choose',
      name: 'general_choose',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get general_email {
    return Intl.message(
      'Email',
      name: 'general_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get general_password {
    return Intl.message(
      'Password',
      name: 'general_password',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get general_edit {
    return Intl.message(
      'Edit',
      name: 'general_edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get general_save {
    return Intl.message(
      'Save',
      name: 'general_save',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get general_refresh {
    return Intl.message(
      'Refresh',
      name: 'general_refresh',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get general_update {
    return Intl.message(
      'Update',
      name: 'general_update',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get general_skip {
    return Intl.message(
      'Skip',
      name: 'general_skip',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get general_you_sure {
    return Intl.message(
      'Are you sure?',
      name: 'general_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `You will lose unsaved information if you exit from the page`
  String get general_not_saved_lost {
    return Intl.message(
      'You will lose unsaved information if you exit from the page',
      name: 'general_not_saved_lost',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get general_exit {
    return Intl.message(
      'Exit',
      name: 'general_exit',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get general_show {
    return Intl.message(
      'Show',
      name: 'general_show',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get general_create {
    return Intl.message(
      'Create',
      name: 'general_create',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get general_error {
    return Intl.message(
      'Error',
      name: 'general_error',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get general_time_start {
    return Intl.message(
      'Start',
      name: 'general_time_start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get general_time_end {
    return Intl.message(
      'End',
      name: 'general_time_end',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get general_version {
    return Intl.message(
      'Version',
      name: 'general_version',
      desc: '',
      args: [],
    );
  }

  /// `b`
  String get general_bytes_short {
    return Intl.message(
      'b',
      name: 'general_bytes_short',
      desc: '',
      args: [],
    );
  }

  /// `Kb`
  String get general_kilobytes_short {
    return Intl.message(
      'Kb',
      name: 'general_kilobytes_short',
      desc: '',
      args: [],
    );
  }

  /// `Mb`
  String get general_megabytes_short {
    return Intl.message(
      'Mb',
      name: 'general_megabytes_short',
      desc: '',
      args: [],
    );
  }

  /// `Gb`
  String get general_gigabytes_short {
    return Intl.message(
      'Gb',
      name: 'general_gigabytes_short',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get general_reset {
    return Intl.message(
      'Reset',
      name: 'general_reset',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get general_done {
    return Intl.message(
      'Done',
      name: 'general_done',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get general_first_name {
    return Intl.message(
      'First name',
      name: 'general_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get general_last_name {
    return Intl.message(
      'Last name',
      name: 'general_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get general_message {
    return Intl.message(
      'Message',
      name: 'general_message',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get general_phone {
    return Intl.message(
      'Phone',
      name: 'general_phone',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get general_phone_number {
    return Intl.message(
      'Phone number',
      name: 'general_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get general_link {
    return Intl.message(
      'Link',
      name: 'general_link',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get general_event {
    return Intl.message(
      'Event',
      name: 'general_event',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get general_events {
    return Intl.message(
      'Events',
      name: 'general_events',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get general_camera {
    return Intl.message(
      'Camera',
      name: 'general_camera',
      desc: '',
      args: [],
    );
  }

  /// `Cameras`
  String get general_cameras {
    return Intl.message(
      'Cameras',
      name: 'general_cameras',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get general_group {
    return Intl.message(
      'Group',
      name: 'general_group',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get general_groups {
    return Intl.message(
      'Groups',
      name: 'general_groups',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get general_application {
    return Intl.message(
      'App',
      name: 'general_application',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get general_application_doc {
    return Intl.message(
      'Application',
      name: 'general_application_doc',
      desc: '',
      args: [],
    );
  }

  /// `Applications`
  String get general_applications_doc {
    return Intl.message(
      'Applications',
      name: 'general_applications_doc',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get general_notification {
    return Intl.message(
      'Notification',
      name: 'general_notification',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get general_notifications {
    return Intl.message(
      'Notifications',
      name: 'general_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get general_comment {
    return Intl.message(
      'Comment',
      name: 'general_comment',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get general_filter {
    return Intl.message(
      'Filter',
      name: 'general_filter',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get general_analytics {
    return Intl.message(
      'Analytics',
      name: 'general_analytics',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
