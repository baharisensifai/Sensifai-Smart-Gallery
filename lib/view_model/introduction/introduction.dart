import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:permission_handler/permission_handler.dart' as access;
import '../../utils/permissions/permission_manager.dart';
import '../../view/navigation/navigation.dart';
import '../../view/notification/notification.dart';

class OnBoardingViewModel with ChangeNotifier, DiagnosticableTreeMixin {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  void onIntroEnd(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const Navigation()),
            (route) => false
    );
  }

  void goToRequestNotificationPermission(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => const NotificationScreen())
    );
  }

  void requestStoragePermission (BuildContext context) async {
    AndroidDeviceInfo? android ;
    if (Platform.isAndroid){
      android = await deviceInfoPlugin.androidInfo;
    }
    await PermissionManager.requestPermission(
      context,
      Platform.isAndroid ? ((android?.version.sdkInt ?? 0) >= 33 ? access.Permission.photos : access.Permission.storage)
          : access.Permission.photos,
      title: 'permission_storage_title',
      description: 'permission_storage_description',
      icon: Icons.sd_storage,
      onDenied: (){

      },
      onGranted: () async {
        bool granted = await (Platform.isAndroid ? (int.parse((android?.version.sdkInt).toString()) >= 33 ? access.Permission.photos : access.Permission.storage) : access.Permission.photos).isGranted;
        if (granted){
          if (!await FlutterForegroundTask.canDrawOverlays) {
            final isGranted = await FlutterForegroundTask.openSystemAlertWindowSettings();
            if (isGranted){
              bool ignored = await FlutterForegroundTask.requestIgnoreBatteryOptimization();
              if (ignored){
                await checkNotificationPermission(context);
              }
            }
          } else {
            bool ignored = await FlutterForegroundTask.requestIgnoreBatteryOptimization();
            if (ignored){
              await checkNotificationPermission(context);
            }
          }
        }
      },
    );
  }

  Future<void> checkNotificationPermission (BuildContext context) async {
    var notificationPermissionIsGranted = await access.Permission.notification.isGranted;
    if (notificationPermissionIsGranted) {
      onIntroEnd(context);
    } else {
      goToRequestNotificationPermission(context);
    }
  }
}
