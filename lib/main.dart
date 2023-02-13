import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_foreground_task/ui/with_foreground_task.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/utils/permissions/permission_manager.dart';
import 'package:smart_gallery/utils/services/foregroud_service.dart';
import 'package:smart_gallery/utils/storage/database.dart';
import 'package:provider/provider.dart';
import 'package:smart_gallery/view/introduction/introduction.dart';
import 'package:smart_gallery/view/navigation/navigation.dart';
import 'package:smart_gallery/view_model/album/album.dart';
import 'package:smart_gallery/view_model/files/files.dart';
import 'package:smart_gallery/view_model/gallery/gallery.dart';
import 'package:smart_gallery/view_model/image/image.dart';
import 'package:smart_gallery/view_model/introduction/introduction.dart';
import 'package:smart_gallery/view_model/likes/likes.dart';
import 'package:smart_gallery/view_model/navigation/navigation.dart';
import 'package:image_vision/image_vision.dart';
import 'package:smart_gallery/view_model/search/map/map.dart';
import 'package:smart_gallery/view_model/search/person/person.dart';
import 'package:smart_gallery/view_model/search/search.dart';
import 'package:workmanager/workmanager.dart';


@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      bool initialed = await ImageVision.initial();
      if (initialed){
        try {
          ForegroundTask ft = ForegroundTask();
          await ft.initial();
          await ft.startForegroundService();
          return true ;
        } catch (e){
          if (kDebugMode) {
            print("ERRRRRRROOOORRRR: $e");
          }
          return false;
        }
      } else {
        return false ;
      }
    } catch (e){
      if (kDebugMode){
        print(e);
      }
      return false ;
    }
  });
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Databases.initialDatabases();
  await ImageVision.initial();

  String box = "settings" ;
  LazyBox<String> settings = Hive.isBoxOpen(box) ? Hive.lazyBox(box) : await Hive.openLazyBox(box);
  String? darkMode = await settings.get("darkMode", defaultValue: "system");
  if (darkMode == null){
    return ;
  }


  // bool granted = await access.Permission.storage.isGranted ;
  // if (granted){
  //   Workmanager().initialize(
  //       callbackDispatcher, // The top level function, aka callbackDispatcher
  //       isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //   );
  //
  //   Workmanager().registerPeriodicTask("task-identifier", "simpleTask", frequency: const Duration(minutes: 15));
  // }

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo? android ;
  if (Platform.isAndroid){
    android = await deviceInfoPlugin.androidInfo;
  }
  bool isGrantedPhotosPermission = await PermissionManager.isGranted(Platform.isAndroid ? ((android?.version.sdkInt ?? 0) >= 33 ? Permission.photos : Permission.storage) : Permission.photos);
  bool canDrawOverlays = await FlutterForegroundTask.canDrawOverlays ;
  bool isIgnoringBatteryOptimizations = await FlutterForegroundTask.isIgnoringBatteryOptimizations;
  bool isGrantedNotificationsPermission = await PermissionManager.isGranted(Permission.notification);
  bool allPermissionsIsGranted = isGrantedPhotosPermission && canDrawOverlays && isIgnoringBatteryOptimizations && isGrantedNotificationsPermission;
  runApp(
      // Initial for multi language support with [EasyLocalization] dependency
      EasyLocalization(
          // List of language & countries app support
          supportedLocales: const [
            Locale('en')
          ],
          // start local from language
          startLocale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          // select path of translation files
          path: 'assets/translations',
          // & Run root widget
          child: MultiProvider(
            providers: [
              // Initialing ChangeNotifierProvider's
              ChangeNotifierProvider(create: (_) => OnBoardingViewModel()),
              ChangeNotifierProvider(create: (_) => NavigationViewModel()),
              ChangeNotifierProvider(create: (_) => GalleryViewModel()),
              ChangeNotifierProvider(create: (_) => AlbumViewModel()),
              ChangeNotifierProvider(create: (_) => ImageViewModel()),
              ChangeNotifierProvider(create: (_) => LikesViewModel()),
              ChangeNotifierProvider(create: (_) => FilesViewModel()),
              ChangeNotifierProvider(create: (_) => SearchViewModel()),
              ChangeNotifierProvider(create: (BuildContext context) => MapViewModel(context)),
              ChangeNotifierProvider(create: (BuildContext context) => PersonViewModel(context))
            ],
            child: Application(allPermissionsIsGranted, darkMode),
          )
      )
  );
}



class Application extends StatefulWidget {
  final bool granted ;
  final String darkMode ;
  const Application(this.granted, this.darkMode, {Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  @override
  Application get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return WithForegroundTask(
      child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              theme: ThemeData(
                  backgroundColor: const Color(0xFFFFFFFF),
                  fontFamily: 'productSans',
                  primaryColor: Colors.black,
                  primarySwatch: Colors.green,
                  dividerColor: Colors.black,
                  buttonColor: Colors.green,
                  primaryColorDark: Colors.green
              ),
              darkTheme: ThemeData(
                  backgroundColor: const Color(0xFF2B2B2B),
                  fontFamily: 'productSans',
                  primaryColor: Colors.white,
                  primarySwatch: Colors.green,
                  dividerColor: Colors.white,
                  buttonColor: Colors.green,
                  primaryColorDark: Colors.green
              ),
              title: 'Smart Gallery',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: !widget.granted ? const OnBoardingPage() : const Navigation(),
              themeMode: widget.darkMode == "system" ? ThemeMode.system : (widget.darkMode == "dark" ? ThemeMode.dark : ThemeMode.light),
            );
          }
      ),
    );
  }
}
