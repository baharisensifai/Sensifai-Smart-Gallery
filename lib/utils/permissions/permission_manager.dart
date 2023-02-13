import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_settings/system_settings.dart';

import '../ui/theme/widgets/tm_icon.dart';
import '../ui/theme/widgets/tm_text.dart';

class PermissionManager {

  static Future<bool> isGranted (Permission permission) async {
    bool granted = await permission.isGranted;
    return granted ;
  }

  static Future<PermissionStatus> getStatus (Permission permission) async {
    PermissionStatus status = await permission.status;
    return status ;
  }

  static Future<bool> doTheWorkRequiredToGainAccess (Permission permission) async {
    PermissionStatus status = await permission.status;
    switch (status){
      case PermissionStatus.granted:
        return true ;
      case PermissionStatus.denied:
        // TODO: Handle this case.
        return false ;
      case PermissionStatus.restricted:
        // TODO: Handle this case.
        return false ;
      case PermissionStatus.limited:
        // TODO: Handle this case.
        return false ;
      case PermissionStatus.permanentlyDenied:
        // TODO: Handle this case.
        return false ;
    }
  }

  static Future < void > requestPermission ( BuildContext context, Permission permission, {String? title, String? description, IconData? icon, Function()? onGranted, Function()? onDenied, Function()? onPermanentlyDenied}) async {

    PermissionStatus status = await permission.status;

    if (status.isPermanentlyDenied) {

      if(onPermanentlyDenied != null){
        onPermanentlyDenied();
      }
      showPermanentlyDeniedDialog(context);

      return ;
    }


    if (status.isGranted){
      if(onGranted != null){
        onGranted();
      }

      return;
    }

    showRequestPermissionDialog(context, permission, icon: icon, title: title, description: description, onGranted: onGranted, onDenied: onDenied, onPermanentlyDenied: onPermanentlyDenied);

  }

}




void showPermanentlyDeniedDialog ( BuildContext context ) async  {
  showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      builder: (builder){
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TMIcon(Icons.settings),
                  ),
                  TMText('system_permission_limit'.toString().tr(), fontWeight: FontWeight.bold, fontSize: 18)
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: TMText('system_permission_limit_description'.tr(), textAlign: TextAlign.justify, fontSize: 14, height: 2),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: (){
                          SystemSettings.app();
                          Navigator.pop(builder);
                        },
                        child: Text('go_settings'.tr()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child:  SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: (){
                          Navigator.pop(builder);
                        },
                        child: TMText('never_mind'.tr(), color: Colors.grey),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      });
}



void showRequestPermissionDialog ( BuildContext context, Permission permission, {IconData? icon, String? title, String? description, Function()? onGranted, Function()? onDenied, Function()? onPermanentlyDenied}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      builder: (builder){
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TMIcon(icon ?? Icons.perm_device_info),
                  ),
                  TMText(title.toString().tr(), fontWeight: FontWeight.bold, fontSize: 18)
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: TMText(description.toString().tr(), textAlign: TextAlign.justify, fontSize: 14, height: 2),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (Platform.isAndroid){
                            permission.request().then((status){
                              if (status.isGranted){
                                if(onGranted != null){
                                  onGranted.call();
                                }
                              } else if (status.isDenied){
                                if(onDenied != null){
                                  onDenied.call();
                                }
                              } else if (status.isPermanentlyDenied){
                                if(onPermanentlyDenied != null){
                                  onPermanentlyDenied.call();
                                }
                                Navigator.pop(builder);
                                showPermanentlyDeniedDialog.call(context);
                                return;
                              }
                              Navigator.pop(builder);
                            });
                          } else if (Platform.isIOS){
                            permission.request().then((status){
                              if (status.isGranted){
                                if(onGranted != null){
                                  onGranted();
                                }
                              } else if (status.isDenied){
                                if(onDenied != null){
                                  onDenied();
                                }
                              } else if (status.isPermanentlyDenied){
                                if(onPermanentlyDenied != null){
                                  onPermanentlyDenied();
                                }
                                Navigator.pop(builder);
                                showPermanentlyDeniedDialog(context);
                                return;
                              }
                              Navigator.pop(builder);
                            });
                          }

                        },
                        child: Text('yes'.tr()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child:  SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: (){
                          if(onDenied != null){
                            onDenied();
                          }
                          Navigator.pop(builder);
                        },
                        child: Text('no'.tr(), style: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      });
}

