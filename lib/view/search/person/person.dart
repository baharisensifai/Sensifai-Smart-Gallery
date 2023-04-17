import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_gallery/view_model/album/album.dart';

import '../../../utils/storage/database.dart';
import '../../../utils/ui/theme/app_bar.dart';
import '../../../utils/ui/theme/widgets/tm_text.dart';
import '../../../view_model/search/person/person.dart';
import '../../image/image.dart';

class PersonScreen extends StatefulWidget {
  final int id ;
  const PersonScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {

  @override
  void initState() {
    super.initState();
    context.read<PersonViewModel>().loadingFaceDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: getAppBar(
        context,
        actions: [
          IconButton(
              onPressed: (){
                final snackBar = SnackBar(
                  content: const Text('Delete person ?'),
                  action: SnackBarAction(
                    label: 'Yes',
                    onPressed: () async {
                      var face = widget.id;
                      var deleteQuery = "DELETE FROM Faces WHERE id = $face ;";
                      await Databases.modify(deleteQuery);
                      Navigator.pop(context);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: const Icon(Icons.delete_sweep_outlined)
          )
        ]
      ),
      body: Container(
        width: double.infinity,
        height: 100.h,
        padding: const EdgeInsets.all(0),
        child: context.watch<PersonViewModel>().details == null ? Container() : Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      foregroundImage: FileImage(File("${context.watch<PersonViewModel>().details!["face"]}")),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: (){
                      context.read<PersonViewModel>().showChangeNameDialog(context);
                    },
                    child: TMText(context.watch<PersonViewModel>().details!["name"].toString() == "" ? "Add name" : context.watch<PersonViewModel>().details!["name"].toString(), fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 16)
                  ),
                  Expanded(child: Container()),
                  TextButton(onPressed: (){
                    context.read<PersonViewModel>().showMergeModalBottomSheet(context, widget.id);
                  }, child: const Text("Merge"))
                ],
              ),
            ),
            Container(
              height: 72.h,
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: GridView.count(
                controller: context.watch<PersonViewModel>().controller,
                shrinkWrap: false,
                crossAxisCount: 3,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                children: List.generate(
                    context.watch<PersonViewModel>().images.length, (index){
                  var image = context.watch<PersonViewModel>().images[index]! ;
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: Stack(
                      children: [
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.grey[300],
                                child: Hero(
                                  tag: 'image_$index',
                                  child: FadeInImage(
                                      placeholderFit: BoxFit.contain,
                                      fit: BoxFit.cover,
                                      placeholder: const Image(image: AssetImage("assets/images/gif/ld.gif"), fit: BoxFit.contain).image,
                                      image: ThumbnailProvider(
                                        mediumType: MediumType.image,
                                        highQuality: true,
                                        mediumId: image["medium"].toString(),
                                      )
                                  ),
                                )
                              // Image.file(imageAlbums[index].file, fit: BoxFit.cover)
                            ),
                          ),
                          onTap: () async {
                            await context.read<AlbumViewModel>().openImage(context, index, Medium(id: image["medium"].toString()));
                          },
                          onLongPress: () async {
                            final snackBar = SnackBar(
                              content: const Text('Split this person ?'),
                              action: SnackBarAction(
                                label: 'Yes',
                                onPressed: () {

                                },
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                        ),
                      ],
                    ),
                  );
                }
                ),
              ),
            )
          ] ,
        ),
      ),
    );
  }
}
