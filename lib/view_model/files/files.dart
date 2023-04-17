import 'dart:convert';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class FilesViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  List? result ;
  String path = '';
  bool loggedIn = false ;
  bool initialing = true ;
  bool loaded = false ;
  bool check = false ;
  bool isFirstPath = true ;
  bool directoryIsEmpty = false ;

  Future<void> loadDirectory(BuildContext context, {String path = ''}) async {
    if (!loggedIn){
      await loginToDropbox();
      return ;
    }
    load(
        path: path
    ).then((value) {
      notifyListeners();
    }). catchError((e){
      if (kDebugMode) {
        print("EEEEEE - $e");
      }
    });
  }

  Future<void> loginToDropbox ({bool press = false}) async {
    if (press){
      await Dropbox.authorize();
      return;
    }
    LazyBox<String> accounts = Hive.isBoxOpen("accounts") ? Hive.lazyBox("accounts") : await Hive.openLazyBox("accounts");
    await Dropbox.init("reg11w404ra1uh0", "reg11w404ra1uh0", "2ifyyj5siyv3qtf");
    String? token;
    token = await accounts.get("dropbox", defaultValue: null);
    await Dropbox.getAccessToken();
    token ??= await Dropbox.getAccessToken();
    try {
      if (token != null){
        // await accounts.put("dropbox", token);
        await Dropbox.authorizeWithAccessToken(token);
        // if (link == null ) {
        //
        // }
        final url = await Dropbox.getTemporaryLink('/storage');
        if (url == null) return ;
        if (url.toString().contains("expired_access_token") || url == "error = (null)"){
          check = false ;
          loggedIn = false ;
          initialing = false ;
          if (accounts.containsKey("dropbox")){
            await accounts.delete("dropbox");
          }
          notifyListeners();
        } else {
          check = false ;
          loggedIn = true ;
          initialing = false ;
          await accounts.put("dropbox", token);
          load();
        }
      } else {
        if (check){
          check = false ;
          notifyListeners();
          return;
        }
        check = true ;
        initialing = false ;
        notifyListeners();
      }
    } catch (e){
      print("EEEEEE2 - $e");
      // if (kDebugMode){
      //   print(e);
      // }
      initialing = false ;
      loggedIn = false ;
      loaded = true ;
      await accounts.delete("dropbox");
      loginToDropbox();
    }
  }


  Future<void> load({String path = ''}) async {
    await Future.delayed(const Duration(milliseconds: 250));
    this.path = path ;
    if (path == ''){
      isFirstPath = true;
      notifyListeners();
    } else {
      isFirstPath = false;
      notifyListeners();
    }
    loaded = false;
    notifyListeners();
    LazyBox<String> accounts = Hive.isBoxOpen("accounts") ? Hive.lazyBox("accounts") : await Hive.openLazyBox("accounts");
    try {
      var result = await Dropbox.listFolder(path);
      this.result = result;
      try {
        if ((result as List).isEmpty){
          directoryIsEmpty = true ;
        } else {
          directoryIsEmpty = false ;
        }
      } catch (e){
        directoryIsEmpty = false ;
        if (kDebugMode){
          print(e);
        }
      }

      loaded = true ;
      loggedIn = true ;
      initialing = false ;

      // this.result = result ;
      // this.path = path ;
      // if (kDebugMode) {
      //   print("${result.runtimeType} - ${json.encode(result)}");
      // }
      notifyListeners();
    } catch (e){
      print("EEEEEE3 - $e");
      await accounts.delete("dropbox");
      loggedIn = false ;
      loaded = true ;
      initialing = false ;
      notifyListeners();
      // loginToDropbox();
    }
  }
}