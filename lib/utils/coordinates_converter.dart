import 'package:flutter/foundation.dart';

class CoordinatesConverter {

  /// This method convert DMS coordinates to latlng coordinates
  /// for use this function you must use below few lines of example codes
  /// pass [[43, 21, 25]] to [latArray] - pass [[51, 16, 54]] to [lngArray]
  /// for e.g.
  /// convertDMSToDD([[43, 21, 25]], [[51, 16, 54]]);
  ///
  /// it will return => {
  ///   'lat': 43.356944,
  ///   'lng': 51.281667
  /// }
  ///

  static Map<String, double>? convertDMSToDDStatic(String latArray, String lngArray) {
    try {
      latArray = latArray.replaceAll(" ", "").replaceAll("[", "").replaceAll("]", "");
      lngArray = lngArray.replaceAll(" ", "").replaceAll("[", "").replaceAll("]", "");
      var latDeg = double.parse(latArray.split(",")[0]);
      var latMin = double.parse(latArray.split(",")[1]);
      var latSec = double.parse(latArray.split(",")[2].length > 2 ? latArray.split(",")[2].substring(0, 2) : latArray.split(",")[2]);
      var longDeg = double.parse(lngArray.split(",")[0]);
      var longMin = double.parse(lngArray.split(",")[1]);
      var longSec = double.parse(lngArray.split(",")[2].length > 2 ? lngArray.split(",")[2].substring(0, 2) : lngArray.split(",")[2]);
      var latitude = (latDeg + (latMin / 60) + (latSec / 3600) );
      var longitude = (longDeg + (longMin / 60) + (longSec / 3600) );
      return {
        'lat': latitude,
        'lng': longitude
      };
    } catch (e){
      if (kDebugMode){
        print(e);
      }
      return null;
    }
  }
}