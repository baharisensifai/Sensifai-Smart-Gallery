import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_gallery/utils/ui/theme/app_bar.dart';

import '../../../view_model/search/map/map.dart';


class MapScreen extends StatefulWidget {
  final BuildContext context ;
  const MapScreen(this.context, {super.key});

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {

  void changeState(){
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      context.read<MapViewModel>().getImagesWithExif(widget.context, setState);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              // context.read<MapViewModel>().add(position);
              context.read<MapViewModel>().customInfoWindowController.hideInfoWindow!();
              changeState();
            },
            onCameraMove: (position) {
              context.read<MapViewModel>().customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              context.read<MapViewModel>().customInfoWindowController.googleMapController = controller;
            },
            mapToolbarEnabled: true,
            mapType: MapType.hybrid,
            markers: context.read<MapViewModel>().markers,
            initialCameraPosition: CameraPosition(
              target: context.read<MapViewModel>().latLng,
              zoom: 4,
            ),
          ),
          CustomInfoWindow(
            controller: context.read<MapViewModel>().customInfoWindowController,
            height: 75,
            width: 150,
            offset: 50,
          ),
        ],
      ),
    );
  }
}