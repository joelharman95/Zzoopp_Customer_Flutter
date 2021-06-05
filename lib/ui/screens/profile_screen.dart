import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/data/viewmodel/profile_viewmodel.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';
import 'package:zzoopp_customer/ui/styles/custome_textField.dart';
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

  Widget _fieldWidgets(ProfileViewModel profileViewModel) {
    return Column(
      children: <Widget>[
        _entryField("Name", profileViewModel.nameController, Icon(Icons.person), TextInputType.text, TextInputAction.next),
        _entryField("Phone Number", profileViewModel.phoneNoController, Icon(Icons.phone_in_talk_outlined), TextInputType.phone, TextInputAction.next),
        _entryField("Email", profileViewModel.emailController, Icon(Icons.email_outlined), TextInputType.emailAddress, TextInputAction.next),
        _entryField("Address", profileViewModel.addressController, Icon(Icons.location_on_outlined), TextInputType.streetAddress, TextInputAction.next),
      ],
    );
  }

  Widget _submitButton(BuildContext context, ProfileViewModel profileViewModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          profileViewModel.isFieldValid(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()),);

        },
        style: TextButtonStyles.getTextButtonStyle(
          padding: EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text("Update",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
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
                        _fieldWidgets(profileViewModel),
                        SizedBox(height: 10),
                        _submitButton(context, profileViewModel),
                        SizedBox(height: height * .055),
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
