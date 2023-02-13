import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:smart_gallery/view/image/image.dart';
import 'package:smart_gallery/view_model/image/image.dart';

import '../../utils/storage/database.dart';

class AlbumViewModel with ChangeNotifier, DiagnosticableTreeMixin {


  List<Medium> medias = [] ;

  Future<void> initialAlbum(Album? album, {String? city}) async {
    medias.clear();
    notifyListeners();
    if (city == null){
      await Future.delayed(const Duration(milliseconds: 250));
      if (album != null){
        await getMediumsFromAlbum(album);
      }
    } else {
      await getMediumsFromCity(city);
    }
  }

  Future<void> getMediumsFromAlbum(Album album) async {
    final MediaPage page = await album.listMedia(
      newest: true
    );
    for (int i = 0 ; i < page.items.length ; i++){
      var medium = page.items[i];
      medias.add(medium);
    }
    notifyListeners();
  }

  Future<void> getMediumsFromCity(String city) async {
    List<Map<String, Object?>>? cities = await Databases.runQuery("SELECT * FROM Labels WHERE city = '${city.toLowerCase()}';");
    if (cities == null) return ;

    for (int i = 0 ; i < cities.length ; i++){
      var medium = Medium(id: cities[i]["medium"].toString());
      medias.add(medium);
    }
    notifyListeners();
  }

  Future<void> openImage(BuildContext context, int index, Medium media,
      {Function(dynamic value)? fx}) async {
    File file = await media.getFile();
    await precacheImage(FileImage(file), context);
    await context.read<ImageViewModel>().initImage(index, media, file);
    Navigator.push(context, MaterialPageRoute(builder: (builder) => const ImageScreen())).then((value){
      if (fx != null){
        fx.call(value);
      }
    });
  }

}