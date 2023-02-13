import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/utils/ui/theme/widgets/tm_text.dart';
import 'package:smart_gallery/view_model/likes/likes.dart';

import '../../utils/ui/theme/app_bar.dart';
import '../../view_model/album/album.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {

  @override
  void initState() {
    super.initState();
    context.read<LikesViewModel>().getLikedPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: context.watch<LikesViewModel>().mediums.isEmpty ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Lottie.asset("assets/animations/json/library_empty_state.json", width: double.infinity, height: 25.h, repeat: false),
              const TMText("Nothing found", fontWeight: FontWeight.bold, fontSize: 18,)
            ],
          ) : GridView.count(
        crossAxisCount: 3,
        children: List.generate(context.watch<LikesViewModel>().mediums.length, (index){
          Medium media = context.watch<LikesViewModel>().mediums[index];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: (){
                context.read<AlbumViewModel>().openImage(context, index, media, fx: (value){
                  context.read<LikesViewModel>().getLikedPhotos();
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey[300],
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: 'image_$index',
                    child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage("assets/images/png/sensifai.png"),
                        image: ThumbnailProvider(
                          mediumId: media.id,
                          mediumType: media.mediumType,
                          highQuality: true,
                        )
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
