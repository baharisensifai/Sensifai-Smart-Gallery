import 'dart:convert';
import 'dart:io';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:file_cryptor/file_cryptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/utils/ui/theme/widgets/indicator.dart';
import 'package:smart_gallery/view_model/files/files.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import '../../utils/alert.dart';
import '../../utils/ui/theme/widgets/tm_icon.dart';
import '../../utils/ui/theme/widgets/tm_text.dart';

class FileManager extends StatefulWidget {
  const FileManager({Key? key}) : super(key: key);

  @override
  State<FileManager> createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> with WidgetsBindingObserver {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<FilesViewModel>().loadDirectory(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode){
      print(state.name);
    }
    switch (state){
      case AppLifecycleState.resumed: {
        Future.delayed(const Duration(milliseconds: 250), (){
          context.read<FilesViewModel>().loginToDropbox();
        });
        break;
      }
      case AppLifecycleState.inactive: {

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

  Future<bool> _requestPermission(ph.Permission permission) async {
    return (await permission.request()).isGranted;
  }

  Future<bool> _hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(ph.Permission.storage) &&
          // access media location needed for android 10/Q
          await _requestPermission(ph.Permission.accessMediaLocation) &&
          // manage external storage needed for android 11/R
          await _requestPermission(ph.Permission.manageExternalStorage)) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await _requestPermission(ph.Permission.photos)) {
        return true;
      } else {
        return false;
      }
    } else {
      // not android or ios
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: context.watch<FilesViewModel>().directoryIsEmpty ? SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Lottie.asset("assets/animations/json/empty.json", repeat: false),
            ),
            const SizedBox(height: 0),
            const TMText("Directories not here", fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1.2)
          ],
        ),
      ) : (context.watch<FilesViewModel>().loggedIn ? Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: context.watch<FilesViewModel>().loaded ? ListView.builder(
            itemCount: context.watch<FilesViewModel>().result?.length != null ? context.watch<FilesViewModel>().result!.length + 1 : 1,
            itemBuilder: (context, index){
              if (index == 0){
                return  context.watch<FilesViewModel>().isFirstPath == false ? Container(
                  height: 45,
                  width: 100.w,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orangeAccent
                  ),
                  child: InkWell(
                    onTap: () async {
                      var current = context.read<FilesViewModel>().path;
                      var parentSplit = current.split("/");
                      parentSplit.removeAt(parentSplit.length - 1);
                      String newPath = "";
                      for (int i = 0 ; i < parentSplit.length ; i++){
                        if (parentSplit[i].isNotEmpty){
                          newPath += "/${parentSplit[i]}";
                        }
                      }
                      if (kDebugMode) {
                        print(newPath);
                      }
                      if (current.isEmpty){
                        // Navigator.pop(context);
                      } else {
                        context.read<FilesViewModel>().loadDirectory(context, path: newPath);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const TMIcon(Icons.arrow_back_rounded, size: 24),
                          const SizedBox(width: 4),
                          SizedBox(
                              width: 75.w,
                              child: TMText("Back ${context.watch<FilesViewModel>().path}", fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5, overflow: TextOverflow.ellipsis, softWrap: true, textWidthBasis: TextWidthBasis.parent)
                          )
                        ],
                      ),
                    ),
                  ),
                ) : const SizedBox();
              }
              // TMText(context.watch<FilesViewModel>().result![index - 1]["name"])
              return Container(
                margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: InkWell(
                  onLongPress: (){
                    var snackBar = SnackBar(
                      content: const Text('Do you want to download ?'),
                      action: SnackBarAction(
                        label: 'Download',
                        onPressed: () async {
                          Alert alert = Alert(context);
                          alert.error("Download Failed", "Only files can download to device", onTap: (){
                          });
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  onTap: (){
                    if (!context.read<FilesViewModel>().loaded){
                      return;
                    }


                    if (context.read<FilesViewModel>().result![index - 1]["filesize"] != null){
                      var sb = SnackBar(
                          content: const Text('Do you want to download ?'),
                          action: SnackBarAction(
                            label: 'Download',
                            onPressed: () async {
                              var path = context.read<FilesViewModel>().result![index - 1]["pathDisplay"];
                              var name = context.read<FilesViewModel>().result![index - 1]["name"].toString();
                              var nameForSave = context.read<FilesViewModel>().result![index - 1]["name"].toString().substring(0, context.read<FilesViewModel>().result![index - 1]["name"].toString().length - 4);
                              if (kDebugMode) {
                                print(path);
                                print(name);
                                print(nameForSave);
                              }
                              if (!name.endsWith(".aes")){
                                return;
                              }
                              Directory? directory = await getExternalStorageDirectory();
                              if (directory == null) return ;
                              var downloadPath = "${directory.path}/Dropbox/";
                              var downloadDirectory = Directory(downloadPath);
                              if (!(await downloadDirectory.exists())){
                                await downloadDirectory.create();
                              }
                              ProgressDialog pd = ProgressDialog(context: context);
                              pd.show(max: 100, msg: "File Downloading");
                              //
                              var downloadPercent = 0.0 ;
                              var downloadingFilePath = "$downloadPath$name";
                              final result = await Dropbox.download(path, downloadingFilePath, (downloaded, total) async {
                                downloadPercent = ((downloaded * 100) / total);
                                pd.update(value: downloadPercent.toInt() ~/ 100);
                                if (downloaded == total){
                                  var encFile = File(downloadingFilePath);
                                  var path = encFile.path;
                                  if (kDebugMode) {
                                    print(path);
                                  }
                                  FileCryptor fileCryptor = FileCryptor(
                                    key: "Aq==yruvjgihut3756&8453257801271",
                                    iv: 16,
                                    dir: directory.path,
                                  );
                                  File decryptedFile = await fileCryptor.decrypt(inputFile: encFile.path, outputFile: downloadingFilePath.substring(0, downloadingFilePath.length - 4), useCompress: false);
                                  LazyBox<String> paths = Hive.isBoxOpen("paths") ? Hive.lazyBox("paths") : await Hive.openLazyBox("paths");
                                  for (int i = 0 ; i < paths.length ; i++){
                                    var path = await paths.getAt(i);
                                    if (path == downloadPath){
                                      await paths.deleteAt(i);
                                    }
                                  }
                                  await paths.add(downloadingFilePath.substring(0, downloadingFilePath.length - 4));
                                  await encFile.delete();
                                }
                              });
                              //
                              pd.close();
                            },
                          )
                      );
                      // var snackBar = SnackBar(
                      //   content: const Text('Do you want to download ?'),
                      //   action: SnackBarAction(
                      //     label: 'Download',
                      //     onPressed: () async {
                      //       var path = context.read<FilesViewModel>().result![index - 1]["pathDisplay"];
                      //       var name = context.read<FilesViewModel>().result![index - 1]["name"].toString();
                      //       if (path.toString().endsWith("aes")){
                      //         Directory? directory = (await getExternalStorageDirectory());
                      //         if (directory == null) return ;
                      //         var downloadPath = "${directory.path}/Smart-Gallery/";
                      //         var downloadDirectory = Directory(downloadPath);
                      //         if (!(await downloadDirectory.exists())){
                      //           downloadDirectory.create();
                      //         }
                      //         var downloadPercent = 0.0 ;
                      //         try {
                      //           ProgressDialog pd = ProgressDialog(context: context);
                      //           pd.show(max: 100, msg: "File Downloading");
                      //           final result = await Dropbox.download(path, downloadPath, (downloaded, total) async {
                      //             downloadPercent = ((downloaded * 100) / total);
                      //             pd.update(value: downloadPercent.toInt() ~/ 100);
                      //             if (downloaded == total){
                      //               var encFile = File(downloadPath);
                      //               var path = encFile.path;
                      //               var sd = path.split("/");
                      //               var filename = sd[sd.length - 1];
                      //               var fn = filename.replaceAll(".aes", "");
                      //               filename = fn;
                      //               path = path.replaceAll(sd[sd.length - 1], filename);
                      //               print(path);
                      //               print(encFile.path);
                      //
                      //
                      //               LazyBox<String> paths = Hive.isBoxOpen("paths") ? Hive.lazyBox("paths") : await Hive.openLazyBox("paths");
                      //               for (int i = 0 ; i < paths.length ; i++){
                      //                 var path = await paths.getAt(i);
                      //                 if (path == downloadPath){
                      //                   await paths.deleteAt(i);
                      //                 }
                      //               }
                      //               await paths.add(downloadPath);
                      //
                      //               // var encStr = await encFile.readAsString();
                      //               // var key = 'EncryptKey0021';
                      //               // var encrypted = encStr;
                      //               // var bytes = List<int>.from(json.decode(encrypted));
                      //               // await encFile.writeAsBytes(bytes);
                      //               // pd.close();
                      //               // downloadPercent = 0.0;
                      //               // LazyBox<String> paths = Hive.isBoxOpen("paths") ? Hive.lazyBox("paths") : await Hive.openLazyBox("paths");
                      //               // for (int i = 0 ; i < paths.length ; i++){
                      //               //   var path = await paths.getAt(i);
                      //               //   if (path == downloadPath){
                      //               //     await paths.deleteAt(i);
                      //               //   }
                      //               // }
                      //               // await paths.add(downloadPath);
                      //               // Alert alert = Alert(context);
                      //               // alert.success("File downloaded", "Click here to view $downloadPath", onTap: (){
                      //               //   OpenFile.open(downloadPath);
                      //               // }, timeInMS: 5000);
                      //             }
                      //           });
                      //         } catch (e){
                      //           downloadPercent = 0.0 ;
                      //         }
                      //       } else {
                      //         Directory? directory = await getExternalStorageDirectory();
                      //         if (directory == null) return ;
                      //         var downloadPath = "${directory.path}/$name";
                      //         var downloadPercent = 0.0 ;
                      //         try {
                      //           ProgressDialog pd = ProgressDialog(context: context);
                      //           pd.show(max: 100, msg: "File Downloading");
                      //           final result = await Dropbox.download(path, downloadPath, (downloaded, total) async {
                      //             downloadPercent = ((downloaded * 100) / total);
                      //             pd.update(value: downloadPercent.toInt() ~/ 100);
                      //             if (downloaded == total){
                      //               pd.close();
                      //               downloadPercent = 0.0;
                      //               LazyBox<String> paths = Hive.isBoxOpen("paths") ? Hive.lazyBox("paths") : await Hive.openLazyBox("paths");
                      //               for (int i = 0 ; i < paths.length ; i++){
                      //                 var path = await paths.getAt(i);
                      //                 if (path == downloadPath){
                      //                   await paths.deleteAt(i);
                      //                 }
                      //               }
                      //               await paths.add(downloadPath);
                      //               Alert alert = Alert(context);
                      //               alert.success("File downloaded", "Click here to view $downloadPath", onTap: (){
                      //                 OpenFile.open(downloadPath);
                      //               }, timeInMS: 5000);
                      //             }
                      //           });
                      //         } catch (e){
                      //           downloadPercent = 0.0 ;
                      //         }
                      //       }
                      //     },
                      //   ),
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(sb);
                    } else {
                      context.read<FilesViewModel>().loadDirectory(context, path: (context.read<FilesViewModel>().result![index - 1]["pathDisplay"]).toString());
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(),
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0x88346EA0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        context.watch<FilesViewModel>().result![index - 1]["filesize"] != null ? const TMIcon(Icons.file_present) : const TMIcon(Icons.folder),
                        const SizedBox(width: 8),
                        SizedBox(
                            width: 60.w,
                            child: TMText(context.watch<FilesViewModel>().result![index - 1]["name"], fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5, overflow: TextOverflow.ellipsis, softWrap: true, textWidthBasis: TextWidthBasis.parent)
                        )
                      ],
                    ),
                  ),
                ),
              );
            }) : Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const [
              SizedBox(
                width: 35,
                height: 35,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: 24),
              TMText("Loading directory", fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)
            ],
          ),
        ),
      ) : (!context.watch<FilesViewModel>().initialing ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset("assets/animations/json/login.json", width: double.infinity, height: 35.h),
          const TMText("Log in to your Dropbox", fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.0, overflow: TextOverflow.ellipsis, softWrap: true, textWidthBasis: TextWidthBasis.parent),
          const SizedBox(
            height: 32,
          ),
          SizedBox(height: 45, width: 50.w, child: ElevatedButton(onPressed: (){
            context.read<FilesViewModel>().loginToDropbox(press: true);
          }, child: const Text("Secure login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))))
        ],
      ) : Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const [
            SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: 16),
            TMText("Initialing Identifier", fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)
          ],
        ),
      ))),
    );
  }
}
