
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/data/viewmodel/profile_viewmodel.dart';
import 'package:zzoopp_customer/ui/screens/change_pwd_screen.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';
import 'package:zzoopp_customer/ui/styles/custome_textField.dart';
import 'package:zzoopp_customer/ui/styles/custome_text_field_with_suffix_icon.dart';
import 'package:zzoopp_customer/ui/styles/text_button_styles.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (ProfileViewModel profileViewModel) {},
      builder: (context, ProfileViewModel viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        body: _ProfileView(),
      ), viewModelBuilder: () => ProfileViewModel(),
      disposeViewModel: false,);
  }
}

enum ButtonFor {
  Update,
  Logout,
  VerifyPhone,
  VerifyEmail,
}

class _ProfileView extends ViewModelWidget<ProfileViewModel>{

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

  Widget _entryFieldWithSuffixIcon(String title, String helperText, BuildContext context, Icon suffixIcon, ProfileViewModel profileViewModel, TextEditingController controller, Icon icon, TextInputType textInputType, TextInputAction textInputAction, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CustomTextFieldWithSuffixIcon(
        controller: controller,
        hint: title,
        helperText: helperText,
        icon: icon,
        obsecure: isPassword,
        textInputType: textInputType,
        textInputAction:  textInputAction,
        suffixIcon: suffixIcon,
        suffixOnTap: () {
          if(title == "Email") {
            profileViewModel.isEmailValid(context);
          } else {
            profileViewModel.isMobileNoValid(context);
          }
        },
      ),
    );
  }

  Widget _textWithSuffixIcon(String title, BuildContext context, Icon suffixIcon, Icon icon, bool isReadOnly) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CustomTextFieldWithSuffixIcon(
        hint: title,
        icon: icon,
        isReadOnly: isReadOnly,
        suffixIcon: suffixIcon,
        suffixOnTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePwdScreen()),);
        },
      ),
    );
  }

  Widget _fieldWidgets(BuildContext context, ProfileViewModel profileViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _entryField("Name", profileViewModel.nameController, Icon(Icons.person), TextInputType.text, TextInputAction.next),
        _entryFieldWithSuffixIcon("Phone Number", "", context, Icon(Icons.arrow_forward_ios_outlined, size: 20,), profileViewModel, profileViewModel.phoneNoController, Icon(Icons.phone_in_talk_outlined), TextInputType.phone, TextInputAction.next),
        _entryFieldWithSuffixIcon("Email", "Verify", context, Icon(Icons.arrow_forward_ios_outlined, size: 20,), profileViewModel, profileViewModel.emailController, Icon(Icons.email_outlined), TextInputType.emailAddress, TextInputAction.next),
        _entryField("Address", profileViewModel.addressController, Icon(Icons.location_on_outlined), TextInputType.streetAddress, TextInputAction.next),
        _textWithSuffixIcon("Change Password", context, Icon(Icons.arrow_forward_ios_outlined, size: 20,), Icon(Icons.lock_outline), true),
      ],
    );
  }

  Widget _submitButton(ButtonFor buttonFor, BuildContext context, ProfileViewModel profileViewModel) {
    String title = "";
    switch (buttonFor) {
      case ButtonFor.Update:
        title = "Update";
        break;
      case ButtonFor.Logout:
        title = "Logout";
        break;
      default:
        title = "Verify";
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        onPressed: () {
          switch (buttonFor) {
            case ButtonFor.Update:
              profileViewModel.isFieldValid(context);
              break;
            case ButtonFor.Logout:
              profileViewModel.logout(context);
              break;
            case ButtonFor.VerifyPhone:
              break;
            case ButtonFor.VerifyEmail:
              break;
          }
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

  Widget _versionLabel(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text('Version - 1.0', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),),
    );
  }

  Widget _progressBar(ProfileViewModel profileViewModel) {
    return Visibility(
        visible: profileViewModel.isBusy,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ));
  }

  @override
  Widget build(BuildContext context, ProfileViewModel profileViewModel) {
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
                        _fieldWidgets(context, profileViewModel),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _submitButton(ButtonFor.Update, context, profileViewModel),
                            _submitButton(ButtonFor.Logout, context, profileViewModel),
                          ],
                        ),
                        SizedBox(height: height * .055),
                        _versionLabel(context),
                      ],
                    ),
                  ),
                ),
                _progressBar(profileViewModel),
              ],
            ),
          ),
        ));
  }

}
