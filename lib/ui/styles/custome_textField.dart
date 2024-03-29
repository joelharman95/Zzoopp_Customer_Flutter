import 'package:flutter/material.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String hint;
  final TextEditingController controller;
  final bool obsecure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isReadOnly;

  const CustomTextField({
    this.controller,
    this.hint,
    this.icon,
    this.obsecure,
    this.textInputType,
    this.textInputAction,
    this.isReadOnly = false,
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
          ),
        ),
      ),
    );
  }
}
