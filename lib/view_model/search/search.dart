import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';

import '../../utils/storage/database.dart';
import '../../view/album/album.dart';
import '../album/album.dart';

class SearchViewModel with ChangeNotifier, DiagnosticableTreeMixin {

  List<Medium> mediums = [];
  List<Map<String, Object?>> cities = [];
  List<Map<String, Object?>> faces = [];
  bool isLoading = false ;


  Future<void> initialSearchScreen() async {
    List<Map<String, Object?>>? cities = await Databases.runQuery("SELECT * FROM Labels WHERE city != '' GROUP BY city;");
    List<Map<String, Object?>>? faces = await Databases.runQuery("SELECT * FROM Faces ;");
    if (cities != null){
      this.cities = cities ;
      notifyListeners();
    }
    if (faces != null){
      this.faces = faces ;
      notifyListeners();
    }
  }

  Future<void> openAlbum(BuildContext context, String city) async {
    isLoading = true ;
    notifyListeners();
    await context.read<AlbumViewModel>().initialAlbum(null, city: city);
    Navigator.push(context, MaterialPageRoute(builder: (builder) => AlbumScreen(title: city)));
    Future.delayed(const Duration(milliseconds: 500), (){
      isLoading = false ;
      notifyListeners();
    });
  }

  Future<void> search (BuildContext context, String word) async {
    if (word.isEmpty){
      mediums.clear();
      notifyListeners();
      return;
    }
    mediums.clear();
    var searchQuery = word.toLowerCase();
    String query = "SELECT * FROM Labels WHERE ";
    query += "labels LIKE '%$searchQuery%' ;";
    var images = await Databases.runQuery(query);
    if (images == null) return ;
    for (int i = 0 ; i < images.length ; i++){
      String id = images[i]["medium"].toString();
      mediums.add(Medium(id: id));
    }
    notifyListeners();
  }
}