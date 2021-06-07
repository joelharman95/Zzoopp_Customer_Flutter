/*
 * Created by Nethaji on 6/6/21 8:44 AM
 * And last updated by Nethaji on 6/6/21 8:44 AM
 */

import 'package:flutter/material.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';

class CustomTextFieldWithSuffixIcon extends StatelessWidget {
  final Icon icon, suffixIcon;
  final String hint, helperText;
  final TextEditingController controller;
  final bool obsecure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isReadOnly;
  final Function suffixOnTap;

  const CustomTextFieldWithSuffixIcon({
    this.controller,
    this.hint,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.obsecure,
    this.textInputType,
    this.textInputAction,
    this.isReadOnly = false,
    this.suffixOnTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextField(
          readOnly: isReadOnly,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          textAlign: TextAlign.justify,
          controller: controller,
          obscureText: obsecure ?? false,
          style: TextStyle(fontSize: 16,),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 20),
              hintStyle: TextStyle(fontSize: 16),
              hintText: hint,
              helperText: helperText == "" ? null : helperText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: AppColors.greyColor,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: AppColors.greyColor,
                  width: 1,
                ),
              ),
              prefixIcon: Padding(
                child: IconTheme(
                  data: IconThemeData(color: AppColors.greyColor),
                  child: icon,
                ),
                padding: EdgeInsets.only(left: 1),
              ),
            suffixIcon: InkWell(
              onTap: () => suffixOnTap(),
              child: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }
}
