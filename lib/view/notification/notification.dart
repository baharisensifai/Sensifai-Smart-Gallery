import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/utils/ui/theme/widgets/tm_text.dart';

import '../../utils/permissions/permission_manager.dart';
import '../../view_model/introduction/introduction.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 4.h),
          Lottie.asset("assets/animations/json/notifs.json", width: double.infinity, height: 15.h, repeat: false),
          const SizedBox(height: 16),
          const Center(
              child: TMText("Notifications is disable!", fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.5,)
          ),
          const SizedBox(height: 12),
          const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TMText("In order to be able to inform you about the processes that are happening in the background, we need to be able to send you notifications. Do you give access?", fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: 1.5, height: 1.5, textAlign: TextAlign.justify, softWrap: true, textDirection: TextDirection.ltr),
              )
          ),
          SizedBox(height: 8.h),
          Lottie.asset("assets/animations/json/nq.json", width: double.infinity, height: 35.h, repeat: true)
        ],
      ),
      bottomSheet: Container(
        color: Theme.of(context).backgroundColor,
        height: 58,
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45,
                child: TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (builder){
                      return AlertDialog(
                        title: const Text("Sorry"),
                        content: const Text("This app can launch with notification permission. in other conditions, app is not launch. :(", style: TextStyle(height: 1.5),),
                        actions: [
                          TextButton(onPressed: (){
                            exit(0);
                      }, child: const Text("Close", style: TextStyle(color: Colors.grey)),),
                          TextButton(onPressed: (){
                            Navigator.pop(builder);
                          }, child: const Text("OK"))
                        ],
                      );
                    });
                  },
                  child: const Text("I don't give access"),
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    await PermissionManager.requestPermission(
                      context,
                      Permission.notification,
                      title: 'notification_permission',
                      description: 'notification_permission_desc',
                      icon: Icons.notifications,
                      onDenied: () {

                      },
                      onGranted: () async {
                        PermissionStatus status = await Permission.notification.request();
                        if (status.isGranted){
                          context.read<OnBoardingViewModel>().onIntroEnd(context);
                        }
                      },
                    );
                  },
                  child: const Text("Yes"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
