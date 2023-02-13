import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utils/storage/database.dart';
import '../../../utils/ui/theme/widgets/tm_text.dart';

class PersonViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  BuildContext context ;
  PersonViewModel(this.context);

  final ScrollController _controller = ScrollController();
  ScrollController? get controller => _controller;

  Map<String, Object?>? details;
  List<Map<String, Object?>?> images = [];

  Future<void> loadingFaceDetails (int id) async {
    List<Map<String, Object?>>? ps = await Databases.runQuery("SELECT * FROM Faces WHERE id = $id ;");
    if (ps != null){
      details = ps[0];
      await Future.delayed(const Duration(milliseconds: 250));
      notifyListeners();
      loadImagesWithSameFace(id);
    }
  }


  Future <void> loadImagesWithSameFace(int id) async {
    List<Map<String, Object?>>? one = await Databases.runQuery("SELECT * FROM Labels WHERE faces LIKE '[$id,%' ;");
    List<Map<String, Object?>>? two = await Databases.runQuery("SELECT * FROM Labels WHERE faces LIKE '%,$id,%' ;");
    List<Map<String, Object?>>? three = await Databases.runQuery("SELECT * FROM Labels WHERE faces LIKE '%,$id]' ;");
    List<Map<String, Object?>>? four = await Databases.runQuery("SELECT * FROM Labels WHERE faces LIKE '[$id]' ;");
    if (one != null && two != null && three != null && four != null){
      List<Map<String, Object?>>? merge = [one, two, three, four].expand((x) => x).toList();
      images = merge ;
      notifyListeners();
    }
  }


  Future<void> showChangeNameDialog(BuildContext context) async {
    if (details == null) return ;
    var name = details!["name"];
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
          )
        ),
        builder: (builder){
          return Container(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24 + MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const TMText("Enter person name", fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      onChanged: (val) async {
                        if (val.isEmpty){
                          name = "";
                          return;
                        }
                        name = val ;
                      },
                      minLines: 1,
                      initialValue: details!["name"].toString(),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          label: const TMText('Name')
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await Databases.modify("UPDATE Faces SET name = '$name' WHERE id = ${details!["id"]};");
                      Navigator.pop(builder);
                      await Future.delayed(const Duration(milliseconds: 500));
                      Navigator.pop(context);
                    },
                    child: Text("Change name".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5)),
                  ),
                )
              ],
            ),
          );
        }
    );
  }



  Future <void> changeFaceId(int oldFace, int newFace) async {
    List<Map<String, Object?>>? faces = await Databases.runQuery("SELECT * FROM Labels WHERE faces LIKE '%$oldFace%' ;");
    if (faces != null){
      for (int i = 0 ; i < faces.length; i++){
        var renew = faces[i]["faces"].toString().
        replaceAll("[$oldFace", "[$newFace")
        .replaceAll(",$oldFace,", ",$newFace,")
        .replaceAll("$oldFace]", "$newFace]");
        var deleteQuery = "UPDATE Labels SET faces = '$renew' WHERE id = ${faces[i]["id"]} ;";
        await Databases.modify(deleteQuery);
      }
    }
  }



  Future<void> showMergeModalBottomSheet(BuildContext context, int face) async {
    List<Map<String, Object?>>? faces = await Databases.runQuery("SELECT * FROM Faces WHERE id != $face ;");
    if (faces == null) return ;
    if (details == null) return ;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (builder){
          return Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("With which one ?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 310,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(faces.length, (index){
                      return InkWell(
                        onTap: () async {
                          var path = details!["faces"];
                          Directory systemTempDir = Directory(path.toString());
                          await for (var entity in systemTempDir.list(recursive: true, followLinks: false)) {
                            var file = File(entity.path);
                            if (!file.path.contains("thumbnail")){
                              var newDir = "${entity.parent.parent.path}/${faces[index]["id"]}/${DateTime.now()}.png";
                              await file.rename(newDir);
                            }
                          }
                          var deleteQuery = "DELETE FROM Faces WHERE id = $face ;";
                          await Databases.modify(deleteQuery);
                          var oldFaceId = face ;
                          var newFaceId = int.parse(faces[index]["id"].toString());
                          await changeFaceId(oldFaceId, newFaceId);
                          Navigator.pop(builder);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16),
                              height: 65,
                              width: 65,
                              child: CircleAvatar(
                                foregroundImage: FileImage(File("${faces[index]["face"]}")),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(faces[index]["name"].toString(), style: const TextStyle(fontSize: 14, color: Colors.blueAccent))
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}