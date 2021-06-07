/*
 * Created by Nethaji on 4/6/21 8:32 PM
 * And last updated by Nethaji on 4/6/21 8:32 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/data/viewmodel/register_viewmodel.dart';
import 'package:zzoopp_customer/ui/screens/profile_screen.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';
import 'package:zzoopp_customer/ui/styles/custome_textField.dart';
import 'package:zzoopp_customer/ui/styles/text_button_styles.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (RegisterViewModel registerViewModel) {},
      builder: (context, RegisterViewModel viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        body: _RegisterView(),
    ), viewModelBuilder: () => RegisterViewModel(),
    disposeViewModel: false,);
  }
}

class _RegisterView extends ViewModelWidget<RegisterViewModel> {

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

  Widget _fieldWidgets(RegisterViewModel registerViewModel) {
    return Column(
      children: <Widget>[
        _entryField("Name", registerViewModel.nameController, Icon(Icons.person), TextInputType.text, TextInputAction.next),
        _entryField("Phone Number", registerViewModel.phoneNoController, Icon(Icons.phone_in_talk_outlined), TextInputType.phone, TextInputAction.next),
        _entryField("Email", registerViewModel.emailController, Icon(Icons.email_outlined), TextInputType.emailAddress, TextInputAction.next),
        _entryField("Address", registerViewModel.addressController, Icon(Icons.location_on_outlined), TextInputType.streetAddress, TextInputAction.next),
        _entryField("Create Password", registerViewModel.passwordController, Icon(Icons.lock), TextInputType.visiblePassword, TextInputAction.next, isPassword: true),
        _entryField("Confirm Password", registerViewModel.confirmPasswordController, Icon(Icons.lock), TextInputType.visiblePassword, TextInputAction.done, isPassword: true),
      ],
    );
  }

  Widget _submitButton(BuildContext context, RegisterViewModel registerViewModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          registerViewModel.isFieldValid(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()),);
        },
        style: TextButtonStyles.getTextButtonStyle(
          padding: EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text("Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _loginAccountLabel(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Existing User?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Log in',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressBar(RegisterViewModel registerViewModel) {
    return Visibility(
      visible: registerViewModel.isBusy,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ));
  }

  @override
  Widget build(BuildContext context, RegisterViewModel registerViewModel) {
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
                        _fieldWidgets(registerViewModel),
                        SizedBox(height: 10),
                        _submitButton(context, registerViewModel),
                        SizedBox(height: height * .055),
                        _loginAccountLabel(context),
                      ],
                    ),
                  ),
                ),
                _progressBar(registerViewModel),
              ],
            ),
          ),
        ));
  }
}