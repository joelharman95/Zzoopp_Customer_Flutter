/*
 *
 *  Created by Mahendra Vijay, Kanmalai Technologies Pvt. Ltd on 8/4/21 5:47 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 8/4/21 4:50 PM by Mahendra Vijay.
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zzoopp_food/ui/styles/colors.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final int size;
  final Color color;
  final FontWeight weight;
  final FontStyle fontStyle;

  const TextWidget({Key key, this.text, this.size, this.color, this.weight, this.fontStyle})
      : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.openSans(
          fontSize: widget.size.toDouble(),
          fontStyle: widget.fontStyle,
          color: widget.color,
          fontWeight: widget.weight),
      softWrap: true,
    );
  }
}

Text headerText(var text) {
  return Text(
    text,
    maxLines: 2,
    style: GoogleFonts.nunito(
        fontSize: 22,
        fontStyle: FontStyle.normal,
        color: AppColors.greyColor,
        fontWeight: FontWeight.w400),
    softWrap: true,
  );
}
