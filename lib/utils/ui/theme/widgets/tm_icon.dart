import 'dart:ui';

import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TMIcon extends material.StatelessWidget {
  final material.IconData data;
  final Color? color ;
  final double? size ;
  const TMIcon(this.data, {this.color, this.size, material.Key? key}) : super(key: key);

  @override
  material.Widget build(material.BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return material.Icon(
        data,
        size: size ?? 24,
        color: color ?? Theme.of(context).dividerColor
    );
  }
}

