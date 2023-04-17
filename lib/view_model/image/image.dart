import 'dart:io';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:file_cryptor/file_cryptor.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_photo_editor/flutter_photo_editor.dart';
import 'package:hive/hive.dart';
import 'package:image_vision/image_vision.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


import '../../utils/storage/database.dart';
import '../../utils/ui/theme/widgets/tm_text.dart';

class ImageViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  int index = 0;
  Medium? media ;
  File? file ;

  List<String> tags = [];
  List<String> options = [];
  bool isLiked = false ;
  bool imageUploaded = false ;
  bool functionRunned = false ;
  List<Map<String, dynamic>> faces = [];

  Future<bool> initialLikedPhoto() async {
    isLiked = false ;
    List<Map<String, Object?>>? likes = await Databases.runQuery("SELECT * FROM Likes WHERE medium = '${media!.id}' ;");
    if (likes == null) return isLiked;
    if (likes.isNotEmpty){
      isLiked = true ;
    } else {
      isLiked = false ;
    }
    if (kDebugMode) {
      print(likes);
    }
    notifyListeners();
    return isLiked ;
  }

  void setOptionsAndTags(List list) async {
    List<String> categorize = [];
    for (int i = 0 ; i < list.length ; i++){
      categorize.add(list[i].toString());
    }
    tags = categorize;
    options = categorize ;
    notifyListeners();
  }

  Future<void> initImage(int index, Medium media, File file) async {
    this.index = index ;
    this.media = media ;
    this.file = file ;
    notifyListeners();
    await initialLikedPhoto();
    download(file);
  }

  void shareImage() {
    if (file == null) return ;
    Share.shareXFiles([XFile((file!.path))], text: '${media!.filename}\n\nImages with labels available on Sensifai' );
  }

  void changeUploadedStatus (bool status){
    imageUploaded = status ;
    notifyListeners();
  }

  void valueChanged(List<String> val) {
    tags = val ;
    // options = val ;
    notifyListeners();
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    if (media == null) return isLiked ;
    if (file == null) return isLiked ;
    this.isLiked = !isLiked;
    if (this.isLiked == false){
      await Databases.modify("DELETE FROM Likes WHERE medium = '${media!.id}';");
    } else {
      await Databases.modify("INSERT INTO Likes ( name, path, medium ) VALUES ( '${media!.filename}', '${file!.path}', '${media!.id}');");
    }
    return await initialLikedPhoto();
  }


  Future<void> editPhoto() async {
    if (file == null) return ;
    FlutterPhotoEditor editor = FlutterPhotoEditor();
    await editor.editImage(file!.path);
  }

  void showLabels(BuildContext context, Medium medium, File file) async {
    String value = "";

    List<Map<String, Object?>>? labels = await Databases.runQuery("SELECT * FROM Labels WHERE medium = '${medium.id}' ;");
    if (labels == null) return ;
    TextEditingController controller = TextEditingController();
    dev.log(labels.toString());
    if (labels.isEmpty){
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16)
            ),
          ),
          builder: (builder){
            return StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                      padding: EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 16,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 16
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TMText("Labels", fontWeight: FontWeight.w600, fontSize: 18, letterSpacing: 1.5),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                Icon(Icons.warning_amber, color: Colors.orange, size: 50),
                                SizedBox(height: 16),
                                TMText("Currently not available.", fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.3),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),

                        ],
                      )
                  );
                }
            );
          }
      );
      return;
    } else {
      List tags = List.of(json.decode(labels[0]["labels"].toString()));
      setOptionsAndTags(tags);
    }
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16)
          ),
        ),
        builder: (builder){
          return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                    padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TMText("Labels", fontWeight: FontWeight.w600, fontSize: 18, letterSpacing: 1.5),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          height: 55,
                          child: TextField(
                            controller: controller,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (String value) async {
                              if ( value.isEmpty ) return;
                              if (!options.contains(value)){
                                if (options == tags){
                                  options.add(value);
                                } else {
                                  options.add(value);
                                  tags.add(value);
                                }

                                await Databases.db?.update("Labels",  {
                                  "labels": json.encode(tags)
                                }, where: "medium = '${medium.id}'");

                                AchievementView(
                                  context,
                                  title: "Added successfully",
                                  subTitle: "\"$value\" word added",
                                  //onTab: _onTabAchievement,
                                  icon: const Icon(Icons.done, color: Colors.white),
                                  typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green,
                                  textStyleTitle: const TextStyle(),
                                  textStyleSubTitle: const TextStyle(),
                                  alignment: Alignment.topCenter,
                                  duration: const Duration(milliseconds: 1500),
                                  isCircle: true,
                                ).show();
                              } else {
                                AchievementView(
                                    context,
                                    title: "Already added",
                                    subTitle: "Try with other words",
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                                    borderRadius: BorderRadius.circular(360),
                                    color: Colors.redAccent,
                                    textStyleTitle: const TextStyle(),
                                    textStyleSubTitle: const TextStyle(),
                                    alignment: Alignment.topCenter,
                                    duration: const Duration(milliseconds: 1500),
                                    isCircle: true
                                ).show();
                              }
                              setState((){});

                              controller.text = "";
                              value = "";
                            },
                            onChanged: (text){
                              value = text ;
                            },
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Theme.of(context).primaryColor),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).primaryColor,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green,
                                      width: 1.0,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.0,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Icon(Icons.label_outline, color: Theme.of(context).primaryColor),
                                hintText: "New label",
                                hintStyle: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.done, color: Colors.blueAccent),
                                  onPressed: () async {
                                    if ( value.isEmpty ) return;
                                    if (!options.contains(value)){
                                      if (options == tags){
                                        options.add(value);
                                      } else {
                                        options.add(value);
                                        tags.add(value);
                                      }

                                      await Databases.db?.update("Labels",  {
                                        "labels": json.encode(tags)
                                      }, where: "medium = '${medium.id}'");

                                      AchievementView(
                                          context,
                                          title: "Added successfully",
                                          subTitle: "\"$value\" word added",
                                          //onTab: _onTabAchievement,
                                          icon: const Icon(Icons.done, color: Colors.white),
                                          typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.green,
                                          textStyleTitle: const TextStyle(),
                                          textStyleSubTitle: const TextStyle(),
                                          alignment: Alignment.topCenter,
                                          duration: const Duration(milliseconds: 1500),
                                          isCircle: true
                                      ).show();
                                    } else {
                                      AchievementView(
                                          context,
                                          title: "Already added",
                                          subTitle: "Try with other words",
                                          icon: const Icon(Icons.close, color: Colors.white),
                                          typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.redAccent,
                                          textStyleTitle: const TextStyle(),
                                          textStyleSubTitle: const TextStyle(),
                                          alignment: Alignment.topCenter,
                                          duration: const Duration(milliseconds: 1500),
                                          isCircle: true
                                      ).show();
                                    }
                                    setState((){});
                                    controller.text = "";
                                    value = "";
                                  },
                                )
                            ),
                          ),
                        ),
                        ChipsChoice<String>.multiple(
                          value: tags,
                          spinnerColor: Colors.green,
                          choiceActiveStyle: C2ChoiceStyle(
                            labelStyle: const TextStyle(color: Colors.green),
                            // backgroundColor: Colors.green,
                            borderColor: Colors.green,
                            color: Colors.green,
                            brightness: MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness,
                            disabledColor: Colors.black,
                            // disabledColor: Colors.black,
                          ),
                          choiceStyle: C2ChoiceStyle(
                            labelStyle: const TextStyle(color: Colors.green),
                            // backgroundColor: Colors.green,
                            borderColor: Colors.green,
                            borderWidth: 0.5,
                            color: Colors.green,
                            brightness: MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness,
                            disabledColor: Colors.black,
                            // disabledColor: Colors.black,
                          ),
                          onChanged: (val) async {
                            setState((){
                              valueChanged(val);
                            });
                            await Databases.db?.update("Labels",  {
                              "labels": json.encode(val)
                            }, where: "medium = '${medium.id}'");
                            AchievementView(
                                context,
                                title: "Info!",
                                subTitle: "Labels changed!",
                                icon: const Icon(Icons.info, color: Colors.white),
                                typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                                borderRadius: BorderRadius.circular(360),
                                color: Colors.blueAccent,
                                textStyleTitle: const TextStyle(),
                                textStyleSubTitle: const TextStyle(),
                                alignment: Alignment.topCenter,
                                duration: const Duration(milliseconds: 1500),
                                isCircle: true
                            ).show();
                          },
                          placeholder: "No items found",
                          placeholderStyle: TextStyle(color: Theme.of(context).primaryColor),
                          choiceItems: C2Choice.listFrom<String, String>(
                            source: options,
                            value: (i, v) => v,
                            label: (i, v) => v,
                          ),
                        )
                      ],
                    )
                );
              }
          );
        }
    );
  }

  Future<void> download(File file) async {
    imageUploaded = false ;
    functionRunned = false ;
    await Future.delayed(const Duration(milliseconds: 200));
    notifyListeners();
    String path = "${file.path.toString()}.aes";
    if (kDebugMode) {
      print(path);
    }
    try {
      String? url = await Dropbox.getTemporaryLink(path);
      if (url == 'Exception in 2/files/get_temporary_link: {".tag":"path","path":"not_found"}'
          || url == 'Unable to resolve host "api.dropboxapi.com": No address associated with hostname'){
        imageUploaded = false ;
      } else {
        imageUploaded = true ;
      }
    } catch (e){
      imageUploaded = false ;
    }
    functionRunned = true ;
    notifyListeners();
  }

  Future<void> backupImage(BuildContext context) async {
    if (file == null) return ;
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: "File Uploading", progressType: ProgressType.normal, hideValue: true);
    await Dropbox.init("reg11w404ra1uh0", "reg11w404ra1uh0", "2ifyyj5siyv3qtf");

    final cDirectory = Directory("${file?.parent.path}/SmartGallery");
    if (!(await cDirectory.exists())){
      await cDirectory.create();
    }
    final directory = await getApplicationDocumentsDirectory();
    FileCryptor fileCryptor = FileCryptor(
      key: "Aq==yruvjgihut3756&8453257801271",
      iv: 16,
      dir: directory.path,
    );
    var output = "${(media?.filename).toString()}.aes";
    var uploadPath = "${file?.parent.path.toString()}/$output";
    File encryptedFile = await fileCryptor.encrypt(inputFile: (file?.path).toString(), outputFile: output, useCompress: false);
    LazyBox<String> accounts = Hive.isBoxOpen("accounts") ? Hive.lazyBox("accounts") : await Hive.openLazyBox("accounts");
    String? token;
    token = await accounts.get("dropbox", defaultValue: null);
    token ??= await Dropbox.getAccessToken();
    if (token != null){
      try {
        final url = await Dropbox.getTemporaryLink('/');
        if (url == null) return ;
        if (url.contains("expired_access_token")){
          await accounts.delete("dropbox");
          notifyListeners();
        } else {
          final result = await Dropbox.upload(encryptedFile.path.toString(), uploadPath, (uploaded, total) {
            if (uploaded == total){
              changeUploadedStatus(true);
              AchievementView(
                  context,
                  title: "Good Job. :)",
                  subTitle: "Photo uploaded to Dropbox",
                  icon: const Icon(Icons.done, color: Colors.white),
                  typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                  borderRadius: BorderRadius.circular(350),
                  color: Colors.green,
                  textStyleTitle: const TextStyle(),
                  textStyleSubTitle: const TextStyle(),
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 1500),
                  isCircle: true
              ).show();
            }
          });
          if (kDebugMode) {
            print(result);
          }
        }
      } catch (e){
        changeUploadedStatus(false);
      }
    } else {
      AchievementView(
          context,
          title: "Login Required",
          subTitle: "Tap here to login to DropBox",
          icon: const Icon(Icons.close, color: Colors.white),
          typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
          borderRadius: BorderRadius.circular(350),
          color: Colors.redAccent,
          textStyleTitle: const TextStyle(),
          textStyleSubTitle: const TextStyle(),
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1500),
          isCircle: true,
          onTap: () async {
            await Dropbox.authorize();
          },
      ).show();
    }
    pd.close();
  }

}