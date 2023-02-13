import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';

class Alert {
  BuildContext context;
  Alert (this.context);

  void success(String title, String subtitle, {Icon? icon, int? timeInMS, GestureTapCallback? onTap}){
    AchievementView(
        context,
        title: title,
        subTitle: subtitle,
        //onTab: _onTabAchievement,
        icon: icon ?? const Icon(Icons.done, color: Colors.white),
        typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
        textStyleTitle: const TextStyle(),
        textStyleSubTitle: const TextStyle(),
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: timeInMS ?? 1500),
        isCircle: true,
        onTap: onTap
    ).show();
  }


  void error(String title, String subtitle, {Icon? icon, int? timeInMS, GestureTapCallback? onTap}){
    AchievementView(
        context,
        title: title,
        subTitle: subtitle,
        //onTab: _onTabAchievement,
        icon: icon ?? const Icon(Icons.close, color: Colors.white),
        typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
        borderRadius: BorderRadius.circular(8),
        color: Colors.redAccent,
        textStyleTitle: const TextStyle(),
        textStyleSubTitle: const TextStyle(),
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: timeInMS ?? 1500),
        isCircle: true,
        onTap: onTap
    ).show();
  }
}