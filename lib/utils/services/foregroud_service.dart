import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:image_vision/image_vision.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

import '../coordinates_converter.dart';
import '../storage/database.dart';

@pragma('vm:entry-point')
void _startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(AddImagesTaskHandler());
}

class ForegroundTask {

  ReceivePort? _receivePort;
  bool isRunningFS = false ;

  bool isRunning(){
    return isRunningFS;
  }

  Future<void> initial () async {
    await _initForegroundTask();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // You can get the previous ReceivePort without restarting the service.
      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = await FlutterForegroundTask.receivePort;
        _registerReceivePort(newReceivePort);
      }
    });
  }


  Future<void> startForegroundService() async {
    await _startForegroundTask();
  }

  Future<void> stopForegroundService() async {
    await _stopForegroundTask();
  }

  Future<bool> _stopForegroundTask() async {
    isRunningFS = false ;
    return await FlutterForegroundTask.stopService();
  }

  Future<void> _initForegroundTask() async {
    FlutterForegroundTask.init(
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'notification_channel_id',
          channelName: 'Foreground Notification',
          channelDescription: 'This notification appears when the foreground service is running.',
          channelImportance: NotificationChannelImportance.LOW,
          priority: NotificationPriority.LOW,
          enableVibration: true,
          visibility: NotificationVisibility.VISIBILITY_PUBLIC,
          playSound: false,
          showWhen: false,
          iconData: const NotificationIconData(
            resType: ResourceType.mipmap,
            resPrefix: ResourcePrefix.ic,
            name: 'launcher',
          ),
          buttons: [
            const NotificationButton(id: 'stop', text: 'CANCEL'),
          ],
        ),
        iosNotificationOptions: const IOSNotificationOptions(
            showNotification: true,
            playSound: true
        ),
        foregroundTaskOptions: const ForegroundTaskOptions(
            interval: 60000,
            autoRunOnBoot: true,
            allowWifiLock: true,
            allowWakeLock: true,
            isOnceEvent: true
        )
    );
  }


  Future<bool> _startForegroundTask() async {
    // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
    // onNotificationPressed function to be called.
    //
    // When the notification is pressed while permission is denied,
    // the onNotificationPressed function is not called and the app opens.
    //
    // If you do not use the onNotificationPressed or launchApp function,
    // you do not need to write this code.
    if (!await FlutterForegroundTask.canDrawOverlays) {
      final isGranted =
      await FlutterForegroundTask.openSystemAlertWindowSettings();
      if (!isGranted) {
        if (kDebugMode) {
          print('SYSTEM_ALERT_WINDOW permission denied!');
        }
        return false;
      }
    }

    List<Album> albums = await PhotoGallery.listAlbums(
      mediumType: MediumType.image,
    );
    Album? sAlbum ;
    for (int i = 0 ; i < albums.length; i++){
      var album = albums[i];
      if (album.name.toString().toLowerCase() == "camera"){
        sAlbum = album;
        break;
      }
    }

    if (sAlbum != null){
      Album album = sAlbum;
      MediaPage imagePage = await album.listMedia(
          newest: true
      );
      List<String> mids = [];
      for (int i = 0 ; i < imagePage.items.length ; i++){
        mids.add(imagePage.items[i].id);
      }
      await FlutterForegroundTask.saveData(key: 'data', value: json.encode(mids));
    }

    bool reqResult;
    if (await FlutterForegroundTask.isRunningService) {
      reqResult = await FlutterForegroundTask.restartService();
    } else {
      reqResult = await FlutterForegroundTask.startService(
        notificationTitle: 'Initialing images...',
        notificationText: 'This may take some time.',
        callback: _startCallback,
      );
    }

    ReceivePort? receivePort;
    if (reqResult) {
      receivePort = await FlutterForegroundTask.receivePort;
    }
    isRunningFS = true ;
    return _registerReceivePort(receivePort);
  }





  bool _registerReceivePort(ReceivePort? receivePort) {
    _closeReceivePort();

    if (receivePort != null) {
      _receivePort = receivePort;
      _receivePort?.listen((message) async {
        // if (message is int){
        //   var id = message;
        //   var row = await Databases.runQuery("SELECT * FROM Images WHERE id = $id");
        //   if (row != null) {
        //     var file = File(row[0]['path'].toString());
        //     var labels = await NavigationState.runModelOnImage(file);
        //     String generatedLabels = json.encode(labels).replaceAll("'", "");
        //     dev.log(generatedLabels);
        //     await Databases.modify("UPDATE Images SET labels = '$generatedLabels', is_tagged = '1' WHERE id = $id;");
        //   }
        // }
      });
      return true;
    }

    return false;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }


  static Future<List<Map<String, dynamic>>> findFaces(File file) async {
    var bytes = await file.readAsBytes();
    String jsonLabels = await ImageVision.detectFacesFromImage(Uint8List.fromList(bytes.toList()));
    var faces = List<Map<String, dynamic>>.from(json.decode(jsonLabels));
    return faces;
  }

  static Future<dynamic> recognizeFace(List<int> face) async {
    var rec = await ImageVision.recognizeFace(Uint8List.fromList(face));
    var split = rec["confidence"].toString().split(".");
    var number = split[0];
    double n = exp(num.parse(number));
    rec["distance"] = rec["confidence"];
    rec["confidence"] = n ;
    return rec;
  }

  static Future<String> register(String name, List<int> face) async {
    var rec = await ImageVision.registerFace(name, Uint8List.fromList(face));
    dev.log(rec.toString());
    return rec ;
  }



  /// only call [startTaggingImages] method when all albums on devices added
  /// to app database
  /// only with calling
  /// ```dart
  /// addImages();
  /// ```
  /// you can pass

  static Future<void> startTaggingImages(List<Medium> mediums, {int index = 0}) async {
    if (index == mediums.length) {
      detectFaces();
      return ;
    }
    int count = await Databases.getCountFromTable("Labels", mainThread: index == 0 ? false : true);
    if (count == mediums.length){
      detectFaces();
      return ;
    }
    Medium medium = mediums[index];
    List<Map<String, Object?>>? labels = await Databases.runQuery("SELECT * FROM Labels WHERE medium = '${medium.id}' ;", mainThread: true);
    // List<int> personsInImage = [];
    if (labels == null) return ;
    if (labels.isNotEmpty){
      int andis = index + 1 ;
      FlutterForegroundTask.updateService(
        notificationTitle: 'Working on $andis / ${mediums.length}',
        notificationText: '$index images added',
        callback: null,
      );
      if (andis <= mediums.length){
        startTaggingImages(mediums, index: andis);
      }
      return ;
    }

    if (kDebugMode) {
      print("{ index: $index, size: ${mediums.length} }");
    }

    try {
      File file = await medium.getFile();
      var bytes = await file.readAsBytes();
      var image = img.decodeImage(bytes);
      var directory = await getExternalStorageDirectory();
      var path = "${directory?.path}";
      List<int> personsInImage = [];


      List<String> tags = [];
      try {
        String jsonLabels = await ImageVision.getTagsOfImage(Uint8List.fromList(bytes.toList()), 0.2);
        var labels = List<Map<String, dynamic>>.from(json.decode(jsonLabels));
        for (int i = 0 ; i < labels.length ; i++){
          tags.add(labels[i]["description"].toString());
        }
      } catch (e){
        if (kDebugMode){
          print(e);
        }
      }

      Map<String, double> latlng = {};
      try {
        final exif = await readExifFromBytes(bytes);
        if (exif['GPS GPSLatitude'] != null && exif['GPS GPSLongitude'] != null){
          try {
            var coordinates = CoordinatesConverter.convertDMSToDDStatic(exif['GPS GPSLatitude'].toString(), exif['GPS GPSLongitude'].toString());
            if (coordinates != null){
              latlng = coordinates;
            }
          } catch(e){
            if(kDebugMode){
              print(e);
            }
          }
        }
      } catch (e){
        if (kDebugMode){
          print(e);
        }
      }

      String cityName = "";

      // try {
      //   cityName = await convertLatLngToCityName(latlng) ?? "" ;
      // } catch (e){
      //   if (kDebugMode){
      //     print(e);
      //   }
      // }

      // try {
      //   List<Map<String, dynamic>> faces = await findFaces(file);
      //   for (int i = 0 ; i < faces.length ; i++){
      //     Map<String, dynamic> face = faces[i];
      //     if (image == null) return ;
      //     var faceCrop = img.copyCrop(
      //         image,
      //         int.parse(face["left"].toString()),
      //         int.parse(face["top"].toString()),
      //         int.parse(face["width"].toString()),
      //         int.parse(face["height"].toString())
      //     );
      //     final png = img.encodePng(faceCrop);
      //     var recognise = await recognizeFace(png);
      //     if (kDebugMode) {
      //       print(recognise);
      //     }
      //     if (recognise["title"] == "face_not_found"){
      //       if (face["right_eye_open_probability"] >= 0.9 && face["left_eye_open_probability"] >= 0.9 && face["smiling_probability"] >= 0.005) {
      //         int? id = await Databases.modify("INSERT INTO Faces ( name, faces, face ) VALUES( '',	'', '' );") ;
      //         if (id == null) return;
      //         if (!personsInImage.contains(id)){
      //           personsInImage.add(id);
      //         }
      //         Directory faceIdDirectory = Directory("$path/$id");
      //         if (!faceIdDirectory.existsSync()){
      //           faceIdDirectory.createSync();
      //         }
      //         var file = File("${faceIdDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png");
      //         await file.writeAsBytes(png);
      //         await Databases.modify("UPDATE Faces SET faces = '${faceIdDirectory.path}', face = '${file.path}' WHERE id = $id");
      //         await register(id.toString(), png);
      //       }
      //     } else if (recognise["title"] != "face_registered" && recognise["title"] != "face_detector_is_null"){
      //       if (recognise["distance"] < 1.0){
      //         var id = recognise["title"].toString() ;
      //         var person = int.parse(id);
      //         if (!personsInImage.contains(person)){
      //           personsInImage.add(person);
      //         }
      //       } else {
      //         if (face["right_eye_open_probability"] >= 0.9 && face["left_eye_open_probability"] >= 0.9 && face["smiling_probability"] >= 0.005) {
      //           int? id = await Databases.modify("INSERT INTO Faces ( name, faces, face ) VALUES( '',	'', '' );") ;
      //           if (id == null) return;
      //           if (!personsInImage.contains(id)){
      //             personsInImage.add(id);
      //           }
      //           Directory faceIdDirectory = Directory("$path/$id");
      //           if (!faceIdDirectory.existsSync()){
      //             faceIdDirectory.createSync();
      //           }
      //           var file = File("${faceIdDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png");
      //           await file.writeAsBytes(png);
      //           await Databases.modify("UPDATE Faces SET faces = '${faceIdDirectory.path}', face = '${file.path}' WHERE id = $id");
      //           await register(id.toString(), png);
      //         }
      //       }
      //     }
      //   }
      // } catch (e){
      //   if (kDebugMode){
      //     print(e);
      //   }
      // }

      try {
        await Databases.modify("INSERT INTO Labels ( name, path, labels, medium, location, city, faces, faces_details, recognised ) VALUES ( '${medium.title}', '${file.path}', '${json.encode(tags)}', '${medium.id}', '${json.encode(latlng)}', '$cityName', '${json.encode(personsInImage)}', '', 'false');", mainThread: true);
      } catch (e){
        if (kDebugMode){
          print("L380 - $e");
        }
      }

      int andis = index + 1 ;
      FlutterForegroundTask.updateService(
        notificationTitle: 'Working on $andis / ${mediums.length}',
        notificationText: '$index images added',
        callback: null,
      );
      if (andis <= mediums.length){
        startTaggingImages(mediums, index: andis);
      }
    } catch (e){
      if (kDebugMode) {
        print("L395 - $e");
      }
      await Databases.modify("INSERT INTO Labels ( name, path, labels, medium, faces_details, recognised ) VALUES ( '${medium.title}', '${(await medium.getFile()).path}', '${json.encode([])}', '${medium.id}', '', 'false');", mainThread: true);
      int andis = index + 1 ;
      FlutterForegroundTask.updateService(
        notificationTitle: 'Working on $andis / ${mediums.length}',
        notificationText: '$index images added',
        callback: null,
      );
      if (andis <= mediums.length){
        startTaggingImages(mediums, index: andis);
      }
      FlutterForegroundTask.updateService(
        notificationTitle: 'Working on ${index + 1} / ${mediums.length}',
        notificationText: '$index images added',
        callback: null,
      );
    }
  }

  static Future<void> addCityToImages () async {
    FlutterForegroundTask.updateService(
      notificationTitle: 'Getting images location\'s',
      notificationText: 'Initialing images ...',
      callback: null,
    );

    bool connectionIsWifi = false ;

    final Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((ConnectivityResult event){
      connectionIsWifi = (event == ConnectivityResult.wifi);
    });
    var connectivityResult = await connectivity.checkConnectivity();
    connectionIsWifi = (connectivityResult == ConnectivityResult.wifi);
    if (!connectionIsWifi){
      FlutterForegroundTask.updateService(
        notificationTitle: 'Wifi not connected',
        notificationText: 'Skipping from locations analyzer ...',
        callback: null,
      );
      Future.delayed(const Duration(milliseconds: 1000), () async {
        await detectFaces();
      });
      return;
    }


    List<Map<String, Object?>>? labels = await Databases.runQuery("SELECT * FROM Labels WHERE location != '{}' AND city = '';", mainThread: true);
    dev.log(labels.toString());
    if (labels == null) {
      detectFaces();
      return ;
    }
    if (labels.isEmpty || labels == []){
      detectFaces();
      return ;
    }

    for (int i = 0 ; i < labels.length ; i++){
      try {
        FlutterForegroundTask.updateService(
          notificationTitle: 'Setup images location\'s',
          notificationText: 'Working on ${(i + 1)} / ${labels.length}',
          callback: null,
        );
        Map<String, Object?> label = labels[i];
        Map<String, dynamic> latlng = json.decode(label["location"].toString());
        if (connectionIsWifi){
          String? city ;
          try {
            city = await convertLatLngToCityName(latlng);
          } catch (e){
            if (kDebugMode){
              print("ACTIF EX: $e");
            }
          }
          if (city != null){
            String query = "UPDATE Labels SET city = '$city' WHERE id = ${label["id"].toString()};";
            await Databases.modify(query);
          }
        }
        if (i == (labels.length - 1)){
          detectFaces();
        }
      } catch (e){
        if (kDebugMode){
          print(e);
        }
        if (i == (labels.length)){
          detectFaces();
        }
      }
    }

  }


  static Future<String?> convertLatLngToCityName(Map<String, dynamic> latlng) async {
    double? lat = latlng["lat"];
    double? lng = latlng["lng"];
    if (lat == null || lng == null) return null ;
    String cityName = "";
    try {
      http.Response response = await http.get(Uri.parse("https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${lat.toString()}&lon=${lng.toString()}&accept-language=en"));
      String city = json.decode(response.body)["address"]["state"] != null ? json.decode(response.body)["address"]["state"].toString().replaceAll(" Province", "").toLowerCase() : json.decode(response.body)["address"]["province"].toString().replaceAll(" Province", "").toLowerCase() ;
      cityName = city ;
    } catch (e){
      if (kDebugMode){
        print("CLLTCN EX: $e");
      }
      return null ;
    }
    return cityName == "" || cityName == "Null" ? null : cityName ;
  }

  static Future<void> detectFaces() async {
    FlutterForegroundTask.updateService(
      notificationTitle: 'Working on faces',
      notificationText: 'Finding faces in images',
      callback: null,
    );

    List<Map<String, Object?>>? labels = await Databases.runQuery("SELECT * FROM Labels WHERE faces_details = '';", mainThread: true);
    if (labels == null) return ;
    if (labels.isEmpty){
      FlutterForegroundTask.updateService(
        notificationTitle: 'All faces found',
        notificationText: 'Going to faces recognition',
        callback: null,
      );
      Future.delayed(const Duration(milliseconds: 1000), () async {
        await recogniseFaces();
      });

      return ;
    }
    for (int i = 0 ; i < labels.length ; i++){
      await Future.delayed(const Duration(milliseconds: 2500));
      FlutterForegroundTask.updateService(
        notificationTitle: 'Searching for faces',
        notificationText: 'Image ${i + 1} / ${labels.length}',
        callback: null,
      );
      Map<String, Object?> label = labels[i];
      File file = File(label["path"].toString());
      Uint8List bytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return ;
      String? jsonFaces;
      try {
        jsonFaces = await ImageVision.detectFacesFromImage(bytes);
      } catch (e){
        if (kDebugMode) {
          print("EODF: $e");
        }
      }
      if (jsonFaces != null){
        await Databases.modify("UPDATE Labels SET faces_details = '$jsonFaces' WHERE id = ${label["id"].toString()};");
      }
      if ( i == (labels.length - 1)){
        FlutterForegroundTask.updateService(
          notificationTitle: 'Face recognition',
          notificationText: 'Initialing images',
          callback: null,
        );
        Future.delayed(const Duration(milliseconds: 1000), () async {
          await recogniseFaces();
        });
      }
    }
  }

  static Future<void> recogniseFaces () async {
    List<Map<String, Object?>>? labels = await Databases.runQuery("SELECT * FROM Labels WHERE faces_details != '' AND recognised != 'true';", mainThread: true);
    if (labels == null) return ;
    if (labels.isEmpty){
      ForegroundTask().stopForegroundService();
      return;
    }
    var directory = await getExternalStorageDirectory();
    var path = "${directory?.path}";
    List<int> personsInImage = [];
    int imageProcess = 0 ;
    for (int i = 0 ; i < labels.length ; i++){
      if (i == 0 ){
        FlutterForegroundTask.updateService(
          notificationTitle: 'Working on $imageProcess / ${labels.length}',
          notificationText: 'Initialing faces',
          callback: null,
        );
      }
      imageProcess = i ;
      Map<String, Object?> label = labels[i];
      var faces = List<Map<String, dynamic>>.from(json.decode(label["faces_details"].toString()));
      File file = File(label["path"].toString());
      Uint8List bytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return ;
      for (int i = 0 ; i < faces.length ; i++){
        FlutterForegroundTask.updateService(
          notificationTitle: 'Working on $imageProcess / ${labels.length}',
          notificationText: 'Working on face ${i + 1} / ${faces.length}',
          callback: null,
        );
        var face = faces[i];
        var faceCrop = img.copyCrop(
            image,
            int.parse(face["left"].toString()),
            int.parse(face["top"].toString()),
            int.parse(face["width"].toString()),
            int.parse(face["height"].toString())
        );
        final png = img.encodePng(faceCrop);
        var response = await ImageVision.recognizeFace(Uint8List.fromList(png));
        if (kDebugMode) {
          dev.log(response.toString());
        }
        double minResponse = 1.0 ;
        double maxResponse = 0.0 ;
        if (response['distance'] != null){
          if (double.parse(response['distance'].toString()) > maxResponse){
            maxResponse = double.parse(response['distance'].toString());
          }
        }
        if (response["title"] == "face_not_found"){
          int? id = await Databases.modify("INSERT INTO Faces ( name, faces, face ) VALUES ( '',	'', '' );") ;
          if (id == null) return;
          if (!personsInImage.contains(id)){
            personsInImage.add(id);
          }
          Directory faceIdDirectory = Directory("$path/$id");
          if (!faceIdDirectory.existsSync()){
            faceIdDirectory.createSync();
          }
          var file = File("${faceIdDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png");

          await file.writeAsBytes(png);
          await Databases.modify("UPDATE Faces SET faces = '${faceIdDirectory.path}', face = '${file.path}' WHERE id = $id");
          await register(id.toString(), png);
        } else {
          if (double.parse(response["distance"].toString()) < 0.5){
            if (double.parse(response['distance'].toString()) < minResponse){
              minResponse = double.parse(response['distance'].toString());
            }
            var id = response["title"].toString();
            var person = int.parse(id);
            if (!personsInImage.contains(person)){
              personsInImage.add(person);
            }
          } else {
            int? id = await Databases.modify("INSERT INTO Faces ( name, faces, face ) VALUES ( '',	'', '' );") ;
            if (id == null) return;
            if (!personsInImage.contains(id)){
              personsInImage.add(id);
            }
            Directory faceIdDirectory = Directory("$path/$id");
            if (!faceIdDirectory.existsSync()){
              faceIdDirectory.createSync();
            }
            var file = File("${faceIdDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png");

            await file.writeAsBytes(png);
            await Databases.modify("UPDATE Faces SET faces = '${faceIdDirectory.path}', face = '${file.path}' WHERE id = $id");
            await register(id.toString(), png);
          }
        }
      }
      await Databases.modify("UPDATE Labels SET faces = '${json.encode(personsInImage)}', recognised = 'true' WHERE id = ${label["id"].toString()}");
      if (i == (labels.length - 1)){
        await FlutterForegroundTask.stopService();
      }
    }
  }
}


class AddImagesTaskHandler extends TaskHandler {
  SendPort? _sendPort;

  String? data = "";

  bool isBusy = false ;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;
    data = (await FlutterForegroundTask.getData<String>(key: 'data')).toString();
    if (data != null){
      if (kDebugMode) {
        print(json.encode(data));
      }
    }
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    if (!isBusy){
      List<Medium> mediums = [];
      if (data != "null" && data != null){
        try {
          var vars = json.decode(data ?? "[]") as List;
          if (vars != []){
            for (int i = 0 ; i < vars.length ; i++){
              mediums.add(Medium(id: vars[i].toString()));
            }
            ForegroundTask.startTaggingImages(mediums);
          }
        } catch (e) {
          dev.log("Starting images error: ${e.toString()}");
        }
        isBusy = true ;
      }
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  @override
  Future<void> onButtonPressed(String id) async {
    if (id == 'stop'){
      await FlutterForegroundTask.stopService();
    }
  }

  @override
  void onNotificationPressed() {
    _sendPort?.send('onNotificationPressed');
  }
}