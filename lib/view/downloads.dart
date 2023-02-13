import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file_plus/open_file_plus.dart';

import 'dart:io';

import '../utils/ui/theme/app_bar.dart';
import '../utils/ui/theme/widgets/tm_text.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {

  List<String> filesPaths = [];
  Future<void> getPaths () async {
    filesPaths = [];
    LazyBox<String> paths = Hive.isBoxOpen("paths") ? Hive.lazyBox("paths") : await Hive.openLazyBox("paths");
    for (int i = 0 ; i < paths.length ; i++){
      var path = await paths.getAt(i);
      if (path != null){
        filesPaths.add(path);
      }
    }
    setState((){
      filesPaths = filesPaths ;
    });
  }


  @override
  void initState(){
    super.initState();
    getPaths();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: getAppBar(context, title: const TMText("Downloads", fontWeight: FontWeight.bold)),
      body: filesPaths.isEmpty ? const Center(
        child: TMText("Downloads directory is empty"),
      ) : GridView.count(crossAxisCount: 3, children: List.generate(filesPaths.length, (index){
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: (){
                OpenFile.open(filesPaths[index]);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(File(filesPaths[index]), fit: BoxFit.cover),
              ),
            ),
          ),
        );
      })),
    );
  }
}
