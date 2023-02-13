import 'package:flutter/foundation.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../utils/storage/database.dart';

class LikesViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  List<Medium> mediums = [];
  Future<void> getLikedPhotos() async {
    mediums.clear();
    List<Map<String, Object?>>? likes = await Databases.runQuery("SELECT * FROM Likes ;");
    if (likes == null) return ;
    for (int i = 0 ; i < likes.length ; i++){
      String id = likes[i]["medium"].toString();
      mediums.add(Medium(id: id));
    }
    notifyListeners();
  }
}