import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/utils/ui/theme/widgets/indicator.dart';
import 'package:smart_gallery/utils/ui/theme/widgets/tm_text.dart';
import 'package:smart_gallery/view_model/gallery/gallery.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  @override
  void initState() {
    super.initState();
    context.read<GalleryViewModel>().getAlbums(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: context.watch<GalleryViewModel>().isLoading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: Indicator.getSpecialForOS(),
            ),
            const SizedBox(
              height: 24,
            ),
            const TMText("Loading images ...", fontSize: 16, fontWeight: FontWeight.bold)
          ],
        ),
      ) : (context.watch<GalleryViewModel>().albums.isEmpty ? Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 18.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Lottie.asset("assets/animations/json/empty_albums.json"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: const TMText("You don't have a camera album", fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ) : GridView.count(
        crossAxisCount: 3,
        children: List.generate(context.watch<GalleryViewModel>().albums.length, (index){
          Album album = context.watch<GalleryViewModel>().albums[index];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: (){
                context.read<GalleryViewModel>().openAlbum(context, album);
              },
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                      color: Colors.grey[300],
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder:
                        const AssetImage("assets/images/gif/ld.gif"),
                        image: AlbumThumbnailProvider(
                          albumId: album.id,
                          mediumType: album.mediumType,
                          highQuality: true,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(album.name.toString(), style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold), maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true, textWidthBasis: TextWidthBasis.parent),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      )),
    );
  }
}
