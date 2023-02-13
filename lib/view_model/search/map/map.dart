import 'dart:convert';
import 'dart:io';

import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/view/image/image.dart';
import 'package:smart_gallery/view/search/search.dart';
import 'package:smart_gallery/view_model/album/album.dart';

import '../../../utils/storage/database.dart';

class MapViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  BuildContext context ;
  MapViewModel(this.context);

  final LatLng _latLng = const LatLng(35.7546406, 51.4061101);
  LatLng get latLng => _latLng ;

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  CustomInfoWindowController get customInfoWindowController => _customInfoWindowController;


  Future<void> getImagesWithExif(BuildContext context, StateSetter setState) async {
    _markers.clear();
    List<Map<String, Object?>>? items = await Databases.runQuery("SELECT * FROM Labels WHERE location != '{}' AND city != '' ;");
    if (items == null) return ;
    for (int i = 0 ; i < items.length ; i++){
      Map? location;
      var id = items[i]["medium"].toString();
      Medium medium = Medium(id: id);
      var path = (await medium.getFile()).path.toString();
      try {
        location = json.decode(items[i]["location"].toString()) as Map;
        if (location.isNotEmpty){
          var lat = location["lat"];
          var lng = location["lng"];

          var position = LatLng(lat, lng);
          add(context, position, setState, path, items[i]["city"].toString().capitalize(), id, medium);
        }
      } catch (e){
        if (kDebugMode){
          print("${items[i]["location"]} $e");
        }
      }
    }
    notifyListeners();
    setState((){});
  }


  void add(BuildContext context, LatLng latLng, StateSetter setState, String filePath, String name, String id, Medium medium){
    var index = _markers.length - 1 ;
    _markers.add(
      Marker(
        markerId: MarkerId(index.toString()),
        position: latLng,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            InkWell(
              onTap: () async {
                await context.read<AlbumViewModel>().openImage(context, index, medium);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Hero(
                                tag: 'image_$index',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(File(filePath), fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 24.w,
                                  child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis, maxLines: 1)
                                ),
                                SizedBox(
                                  width: 24.w,
                                  child: Text("${latLng.latitude},${latLng.longitude}", style: const TextStyle(fontWeight: FontWeight.w100, fontSize: 8), overflow: TextOverflow.ellipsis, maxLines: 1),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.white,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
            ),
            latLng,
          );
        },
      ),
    );
  }

}