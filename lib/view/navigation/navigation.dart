import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/utils/services/foregroud_service.dart';
import 'package:smart_gallery/view/gallery/gallery.dart';
import 'package:workmanager/workmanager.dart';

import '../../main.dart';
import '../../utils/ui/theme/app_bar.dart';
import '../../utils/ui/theme/widgets/tm_text.dart';
import '../../view_model/navigation/navigation.dart';
import '../downloads.dart';
import '../files/files.dart';
import '../likes/likes.dart';
import '../search/search.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> with WidgetsBindingObserver {

  ForegroundTask ft = ForegroundTask();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Workmanager().cancelByUniqueName("tagging");
    try {
      ft.stopForegroundService();
    } catch (e){
      if (kDebugMode){
        print(e);
      }
    }
    ft.initial();
  }

  @override
  void dispose() {
    context.read<NavigationViewModel>().controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    );

    Workmanager().registerPeriodicTask("tagging", "Processing images", frequency: const Duration(minutes: 15));
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode){
      print(state.name);
    }
    switch (state){
      case AppLifecycleState.resumed: {
        Workmanager().cancelByUniqueName("tagging");
        ft.stopForegroundService();
        break;
      }
      case AppLifecycleState.inactive: {
        Workmanager().initialize(
            callbackDispatcher, // The top level function, aka callbackDispatcher
            isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );

        Workmanager().registerPeriodicTask("tagging", "Processing images", frequency: const Duration(minutes: 15));
        // ft.startForegroundService();
        break;
      }
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: getAppBar(
            context,
            leading: IconButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const Downloads()));
              },
              icon: const Icon(Icons.save_as_outlined),
              tooltip: "Downloads",
            )
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SalomonBottomBar(
            itemPadding: EdgeInsets.symmetric(vertical: 0.9.h, horizontal: 5.w),
            currentIndex: context.watch<NavigationViewModel>().index,
            onTap: (i){
              context.read<NavigationViewModel>().changePage(i);
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                activeIcon: const Icon(Icons.photo),
                icon: Icon(Icons.photo_outlined, color: Theme.of(context).primaryColor),
                title: TMText("gallery".tr(), fontWeight: FontWeight.w700, fontFamily: 'productSans', color: Colors.green),
                selectedColor: Colors.lightGreen,
              ),

              /// Search
              SalomonBottomBarItem(
                activeIcon: const Icon(Icons.search),
                icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                title: TMText("search".tr(), fontWeight: FontWeight.w700, fontFamily: 'productSans', color: Colors.green),
                selectedColor: Colors.lightGreen,
              ),

              /// Likes
              SalomonBottomBarItem(
                activeIcon: const Icon(Icons.favorite),
                icon: Icon(Icons.favorite_border, color: Theme.of(context).primaryColor),
                title: TMText("likes".tr(), fontWeight: FontWeight.w700, fontFamily: 'productSans', color: Colors.green),
                selectedColor: Colors.lightGreen,
              ),

              /// Profile
              SalomonBottomBarItem(
                activeIcon: const Icon(Icons.folder_shared_rounded),
                icon: Icon(Icons.folder_shared_outlined, color: Theme.of(context).primaryColor),
                title: TMText("dropbox".tr(), fontWeight: FontWeight.w700, fontFamily: 'productSans', color: Colors.green),
                selectedColor: Colors.lightGreen,
              ),
            ],
          ),
        ),
        body: PageView(
          scrollDirection: Axis.vertical,
          pageSnapping: true,
          physics: const NeverScrollableScrollPhysics(),
          controller: context.watch<NavigationViewModel>().controller,
          children: const [
            Gallery(),
            SearchScreen(),
            LikesScreen(),
            FileManager()
          ],
        )
    );
  }
}
