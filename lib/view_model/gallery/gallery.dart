import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';

import 'package:smart_gallery/view/album/album.dart';
import 'package:smart_gallery/view_model/album/album.dart';

class GalleryViewModel with ChangeNotifier, DiagnosticableTreeMixin {

  List<Album> albums = [];
  bool isLoading = true ;

  Future<void> getAlbums(BuildContext context) async {
    albums.clear();
    List<Album> imageAlbums = await PhotoGallery.listAlbums(
      mediumType: MediumType.image,
    );
    for (int i = 0 ; i < imageAlbums.length ; i++){
      var album = imageAlbums[i];
      if (album.name.toString().toLowerCase() == "camera"){
        albums.add(album);
        await context.read<AlbumViewModel>().getMediumsFromAlbum(album);
      }
    }
    isLoading = false ;
    notifyListeners();
  }


  Future<void> openAlbum(BuildContext context, Album album) async {
    isLoading = true ;
    notifyListeners();
    await context.read<AlbumViewModel>().initialAlbum(album);
    Navigator.push(context, MaterialPageRoute(builder: (builder) => const AlbumScreen()));
    Future.delayed(const Duration(milliseconds: 500), (){
      isLoading = false ;
      notifyListeners();
    });
  }

}