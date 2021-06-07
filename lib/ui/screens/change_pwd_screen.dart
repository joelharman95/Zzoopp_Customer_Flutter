/*
 * Created by Nethaji on 6/6/21 11:56 PM
 * And last updated by Nethaji on 6/6/21 11:56 PM
 */

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/data/viewmodel/change_password_viewmodel.dart';
import 'package:zzoopp_customer/core/data/viewmodel/profile_viewmodel.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';
import 'package:zzoopp_customer/ui/styles/custome_textField.dart';
import 'package:zzoopp_customer/ui/styles/custome_text_field_with_suffix_icon.dart';
import 'package:zzoopp_customer/ui/styles/text_button_styles.dart';

class ChangePwdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (ChangePwdViewModel viewModel) {},
      builder: (context, ChangePwdViewModel viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        body: _ChangePwdView(),
      ), viewModelBuilder: () => ChangePwdViewModel(),
      disposeViewModel: false,);
  }
}

class _ChangePwdView extends ViewModelWidget<ChangePwdViewModel>{

  Widget _logo() {
    return Image.asset("assets/images/img_logo.png");
  }

  Widget _entryField(String title, TextEditingController controller, Icon icon, TextInputType textInputType, TextInputAction textInputAction, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CustomTextField(
        controller: controller,
        hint: title,
        icon: icon,
        obsecure: isPassword,
        textInputType: textInputType,
        textInputAction:  textInputAction,
      ),
    );
  }

  Widget _fieldWidgets(BuildContext context, ChangePwdViewModel changePwdViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _entryField("Old password", changePwdViewModel.oldPasswordController, Icon(Icons.lock_outline), TextInputType.visiblePassword, TextInputAction.next, isPassword: true),
        _entryField("New password", changePwdViewModel.newPasswordController, Icon(Icons.lock_outline), TextInputType.visiblePassword, TextInputAction.next, isPassword: true),
        _entryField("Confirm password", changePwdViewModel.confirmPasswordController, Icon(Icons.lock_outline), TextInputType.visiblePassword, TextInputAction.done, isPassword: true),
      ],
    );
  }

  Widget _submitButton(String title, BuildContext context, ChangePwdViewModel changePwdViewModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          changePwdViewModel.isFieldValid(context);
        },
        style: TextButtonStyles.getTextButtonStyle(
          padding: EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(title,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _progressBar(ChangePwdViewModel changePwdViewModel) {
    return Visibility(
        visible: changePwdViewModel.isBusy,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ));
  }

  @override
  Widget build(BuildContext context, ChangePwdViewModel changePwdViewModel) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .08),
                        _logo(),
                        SizedBox(height: 50),
                        _fieldWidgets(context, changePwdViewModel),
                        SizedBox(height: 10),
                        _submitButton("Change", context, changePwdViewModel),
                        SizedBox(height: height * .055),
                      ],
                    ),
                  ),
                ),
                _progressBar(changePwdViewModel),
              ],
            ),
          ),
        ));
  }

}
