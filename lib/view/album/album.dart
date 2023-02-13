import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:smart_gallery/utils/ui/theme/app_bar.dart';
import 'package:smart_gallery/utils/ui/theme/widgets/tm_text.dart';
import 'package:smart_gallery/view/search/search.dart';
import 'package:smart_gallery/view_model/album/album.dart';

class AlbumScreen extends StatefulWidget {
  final String? title ;
  const AlbumScreen({Key? key, this.title}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: getAppBar(context, title: widget.title != null ? TMText(widget.title.toString().capitalize(), fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.5,) : null),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(context.watch<AlbumViewModel>().medias.length, (index){
          Medium media = context.watch<AlbumViewModel>().medias[index];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: (){
                context.read<AlbumViewModel>().openImage(context, index, media);
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
                      placeholder: const AssetImage("assets/images/gif/ld.gif"),
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
