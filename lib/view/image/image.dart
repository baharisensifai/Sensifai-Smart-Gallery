import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:smart_gallery/view_model/image/image.dart';

import '../../utils/ui/theme/app_bar.dart';
import '../../utils/ui/theme/widgets/tm_icon.dart';
import '../../utils/ui/theme/widgets/tm_text.dart';

class ImageScreen extends StatefulWidget {
  final String title = "Image";
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  bool options = true ;

  @override
  ImageScreen get widget => super.widget;

  @override
  void initState() {
    super.initState();
  }



  void disableOptions(){
    setState((){
      options = false ;
    });
  }

  void enableOptions(){
    setState((){
      options = true ;
    });
  }

  bool isOptionsEnabled (){
    return options ;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: options ? getAppBar(
          context,
          title: TMText(context.watch<ImageViewModel>().media?.filename ?? widget.title, fontWeight: FontWeight.bold),
          // actions: [
          //   IconButton(
          //     onPressed: () async {
          //       await context.read<ImageViewModel>().test(context);
          //     },
          //     icon: const Icon(Icons.transfer_within_a_station),
          //   )
          // ]
        ) : null,
        resizeToAvoidBottomInset: false,
        bottomSheet: options ? Container(
          height: 70,
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: (){
                        // if (file == null) return ;
                        context.read<ImageViewModel>().shareImage();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TMIcon(Icons.share_outlined),
                          const SizedBox(
                            height: 4,
                          ),
                          TMText("share".tr())
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () async {
                        context.read<ImageViewModel>().onLikeButtonTapped(
                            context.read<ImageViewModel>().isLiked
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          context.watch<ImageViewModel>().isLiked ? const TMIcon(Icons.favorite, color: Colors.redAccent) : const TMIcon(Icons.favorite_border),
                          const SizedBox(
                            height: 4,
                          ),
                          TMText("like".tr())
                        ],
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: (){
                        context.read<ImageViewModel>().editPhoto();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TMIcon(Icons.edit_outlined),
                          const SizedBox(
                            height: 4,
                          ),
                          TMText("edit".tr())
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () async {
                        var media = context.read<ImageViewModel>().media;
                        var file = context.read<ImageViewModel>().file;
                        if (media == null || file == null) return ;
                        context.read<ImageViewModel>().showLabels(
                          context,
                          media,
                          file
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TMIcon(Icons.label_outline),
                          const SizedBox(
                            height: 4,
                          ),
                          TMText("labels".tr())
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () async {
                        if (context.read<ImageViewModel>().functionRunned){
                          if (!context.read<ImageViewModel>().imageUploaded){
                            context.read<ImageViewModel>().backupImage(context);
                          } else {
                            AchievementView(
                                context,
                                title: "Umm.",
                                subTitle: "photo exist in Dropbox",
                                icon: const Icon(Icons.done_all, color: Colors.white),
                                typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                                borderRadius: BorderRadius.circular(350),
                                color: Colors.green,
                                textStyleTitle: const TextStyle(),
                                textStyleSubTitle: const TextStyle(),
                                alignment: Alignment.topCenter,
                                duration: const Duration(milliseconds: 1500),
                                isCircle: true
                            ).show();
                          }
                        } else {
                          AchievementView(
                            context,
                            title: "Please wait ...",
                            subTitle: "Finding photo in Dropbox",
                            icon: const Icon(Icons.search, color: Colors.white),
                            typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
                            borderRadius: BorderRadius.circular(350),
                            color: Colors.blueGrey,
                            textStyleTitle: const TextStyle(),
                            textStyleSubTitle: const TextStyle(),
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 1500),
                            isCircle: true
                          ).show();
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TMIcon(context.watch<ImageViewModel>().functionRunned ? (context.watch<ImageViewModel>().imageUploaded ? Icons.done : Icons.backup_outlined) : Icons.image_search_sharp),
                          const SizedBox(
                            height: 4,
                          ),
                          TMText("backup".tr())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ) : null,
        body: Center(
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'image_${context.watch<ImageViewModel>().index}',
            child: context.watch<ImageViewModel>().file != null ? PhotoView(
              minScale: PhotoViewComputedScale.contained * 1.0,
              initialScale: PhotoViewComputedScale.contained * 1.0,
              maxScale: PhotoViewComputedScale.contained * 5.0,
              wantKeepAlive: true,
              imageProvider: FileImage(context.watch<ImageViewModel>().file!),
              onTapUp: (BuildContext context, TapUpDetails details, PhotoViewControllerValue controllerValue){
                if (isOptionsEnabled()){
                  disableOptions();
                } else {
                  enableOptions();
                }
              },
              backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent
              ),
            ) : const Center(
              child: SizedBox(
                width: 35,
                height: 35,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              ),
            ),
          ),
        )
    );
  }
}