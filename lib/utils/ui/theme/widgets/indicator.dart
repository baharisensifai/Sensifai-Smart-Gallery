import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator {
  static dynamic getSpecialForOS(){
    return Platform.isIOS ? const CupertinoActivityIndicator(
      radius: 15,
    ) : const CircularProgressIndicator(
      strokeWidth: 3,
      color: Colors.green,
    );
  }
}