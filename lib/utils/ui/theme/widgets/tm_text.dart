import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';

class TMText extends material.StatelessWidget {
  final String data;
  final material.FontWeight? fontWeight ;
  final double? fontSize ;
  final String? fontFamily ;
  final double? letterSpacing;
  final material.TextOverflow? overflow;
  final bool? softWrap ;
  final TextWidthBasis? textWidthBasis;
  final Color? color ;
  final double? height ;
  final material.TextAlign? textAlign ;
  final material.TextDirection? textDirection ;
  const TMText(this.data, {this.textDirection, this.textAlign = material.TextAlign.justify, this.height, this.color, this.textWidthBasis, this.softWrap, this.overflow, this.letterSpacing, this.fontSize, this.fontWeight, this.fontFamily, material.Key? key}) : super(key: key);

  @override
  material.Widget build(material.BuildContext context) {
    return material.Text(
      data,
      style: material.TextStyle(
          fontSize: fontSize,
          color: color ?? Theme.of(context).primaryColor,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing,
          overflow: overflow,
          height: height,
          fontWeight: fontWeight
      ),
      textAlign: textAlign,
      softWrap: softWrap,
      textDirection: textDirection,
      textWidthBasis: textWidthBasis,
    );
  }
}

