import 'package:flutter/material.dart';
import 'package:zzoopp_food/ui/styles/colors.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String hint;
  final TextEditingController controller;
  final bool obsecure;

  const CustomTextField({
    this.controller,
    this.hint,
    this.icon,
    this.obsecure,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 305,
      height: 47,
      child: TextField(
        textAlign: TextAlign.justify,
        controller: controller,
        obscureText: obsecure ?? false,
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 16),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: AppColors.greyColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: AppColors.greyColor,
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: AppColors.greyColor),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 10, right: 10,bottom: 10),
            )),
      ),
    );
  }
}