import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

AppBar getAppBar (BuildContext context, {Widget? title, Widget? leading, List<Widget>? actions}) {
  var brightness = Theme.of(context).brightness;
  bool isDarkMode = brightness == Brightness.dark;
  return AppBar(
    backgroundColor: Theme.of(context).backgroundColor,
    title: title ?? Image.asset(isDarkMode ? "assets/images/png/logo.png" : "assets/images/png/logo_dark.png", height: 25, color: Theme.of(context).primaryColor),
    centerTitle: true,
    elevation: 0,
    foregroundColor: Theme.of(context).primaryColor,
    leading: leading,
    actions: actions
  );
}