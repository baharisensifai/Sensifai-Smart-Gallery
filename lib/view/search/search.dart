import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:smart_gallery/utils/ui/theme/widgets/indicator.dart';
import 'package:smart_gallery/view/search/map/map.dart';
import 'package:smart_gallery/view/search/person/person.dart';
import 'package:smart_gallery/view_model/search/search.dart';

import '../../utils/ui/theme/widgets/tm_text.dart';
import '../../view_model/album/album.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class _SearchScreenState extends State<SearchScreen> {


  @override
  void initState() {
    super.initState();
    context.read<SearchViewModel>().initialSearchScreen();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<SearchViewModel>().isLoading ? Center(
      child: Indicator.getSpecialForOS(),
    ) : SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 0),
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                onSubmitted: (String word) async {
                  context.read<SearchViewModel>().search(context, word);
                },
                onChanged: (val) async {
                  if (val.isEmpty){
                    FocusScope.of(context).unfocus();
                    context.read<SearchViewModel>().search(context, val);
                  }
                },
                minLines: 1,
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    label: TMText('try_search_anything'.tr())
                ),
              ),
            ),
          ),
          context.watch<SearchViewModel>().faces.isEmpty ? const SizedBox() : const SizedBox(height: 24),
          context.watch<SearchViewModel>().mediums.isNotEmpty ? const SizedBox() : SizedBox(
            width: double.infinity,
            height: context.watch<SearchViewModel>().faces.isEmpty ? 0 : 45,
            child: context.watch<SearchViewModel>().faces.isEmpty ? const SizedBox() : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: TMText("People", textAlign: TextAlign.center, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5,),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: (){

                    },
                    child: const TMText("View more >", textAlign: TextAlign.center, fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: 1.5, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          context.watch<SearchViewModel>().mediums.isNotEmpty ? const SizedBox() : const SizedBox(height: 16),
          context.watch<SearchViewModel>().mediums.isNotEmpty ? const SizedBox() : SizedBox(
            height: context.watch<SearchViewModel>().faces.isEmpty ? 0 : 120,
            child: context.watch<SearchViewModel>().faces.isEmpty ? const SizedBox() : ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(context.watch<SearchViewModel>().faces.length, (index){
                return InkWell(
                  onTap: (){
                    int id = int.parse(context.read<SearchViewModel>().faces[index]["id"].toString());
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => PersonScreen(id: id))).then((value){
                      context.read<SearchViewModel>().initialSearchScreen();
                    });
                  },
                  child: SizedBox(
                      width: 105,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0, right: index == (context.watch<SearchViewModel>().faces.length - 1) ? 0 : 0),
                            child: CircleAvatar(
                              foregroundImage: FileImage(File(context.watch<SearchViewModel>().faces[index]["face"].toString())),
                              radius: 40,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 0.0),
                            child: TMText(context.watch<SearchViewModel>().faces[index]["name"].toString() == "" ? "Add name" : context.watch<SearchViewModel>().faces[index]["name"].toString(), textAlign: TextAlign.center, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 1.5, softWrap: true, textWidthBasis: TextWidthBasis.longestLine, overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                  ),
                );
              }),
            ),
          ),
          context.watch<SearchViewModel>().faces.isEmpty ? const SizedBox() : const SizedBox(height: 32),
          context.watch<SearchViewModel>().mediums.isNotEmpty ? const SizedBox() : const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: TMText("Locations", textAlign: TextAlign.center, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5,),
          ),
          context.watch<SearchViewModel>().mediums.isNotEmpty ? const SizedBox() : const SizedBox(height: 16),
          context.watch<SearchViewModel>().mediums.isNotEmpty ? const SizedBox() : SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(context.watch<SearchViewModel>().cities.length + 1, (index){
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: (){
                    if (index == (context.read<SearchViewModel>().cities.length)) {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => MapScreen(context)));
                      return;
                    }
                    context.read<SearchViewModel>().openAlbum(context, context.read<SearchViewModel>().cities[index]["city"].toString());
                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.only(left: index == 0 ? 8 : 0),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24)
                          ),
                          margin: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: index != (context.watch<SearchViewModel>().cities.length) ? FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: const AssetImage("assets/images/png/sensifai.png"),
                                image: ThumbnailProvider(
                                  mediumId: Medium(id: context.watch<SearchViewModel>().cities[index]["medium"].toString()).id,
                                  mediumType: Medium(id: context.watch<SearchViewModel>().cities[index]["medium"].toString()).mediumType,
                                  highQuality: true,
                                )
                            ) : Image.asset("assets/images/jpeg/map_logo.jpg", fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(24)
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(index == (context.watch<SearchViewModel>().cities.length) ? "View map" : context.watch<SearchViewModel>().cities[index]["city"].toString().capitalize(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2.5),),
                          )
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 1),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(context.watch<SearchViewModel>().mediums.length, (index){
                Medium media = context.watch<SearchViewModel>().mediums[index];
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
          )
        ],
      ),
    );
  }
}
