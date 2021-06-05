/*
 * Created by Nethaji on 5/6/21 12:47 PM
 * And last updated by Nethaji on 5/6/21 12:47 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/data/viewmodel/verify_otp_viewmodel.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';
import 'package:zzoopp_customer/ui/styles/custome_textField.dart';
import 'package:zzoopp_customer/ui/styles/text_button_styles.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (VerifyOtpViewModel viewModel) {},
      builder: (context, VerifyOtpViewModel viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        body: _VerifyOtpView(),
      ),
      viewModelBuilder: () => VerifyOtpViewModel(),
      disposeViewModel: false,
    );
  }
}

class _VerifyOtpView extends ViewModelWidget<VerifyOtpViewModel> {
  Widget _progressBar(VerifyOtpViewModel verifyOtpViewModel) {
    return Visibility(
        visible: verifyOtpViewModel.isBusy,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ));
  }

  Widget _bannerImage(BuildContext context) {
    return Image.asset("assets/images/img_bg.png",
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.4,
    );
  }

  Widget _logo(BuildContext context) {
    return Image.asset(
      "assets/images/img_logo.png",
      fit: BoxFit.contain,
    );
  }

  Widget _otpViewSuccessful() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      alignment: Alignment.center,
      child: Text(
        'OTP Sent Successfully..',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.green),
      ),
    );
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

  Widget _fieldWidgets(VerifyOtpViewModel verifyOtpViewModel) {
    return _entryField("",verifyOtpViewModel.optController, Icon(Icons.phone_in_talk_outlined), TextInputType.phone, TextInputAction.done);
  }

  Widget _submitButton(BuildContext context, VerifyOtpViewModel verifyOtpViewModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          verifyOtpViewModel.isFieldValid(context);
        },
        style: TextButtonStyles.getTextButtonStyle(
          padding: EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text("Verify",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, VerifyOtpViewModel verifyOtpViewModel) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  _bannerImage(context),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Container(height: height/3.7,),
                        _logo(context),
                        _otpViewSuccessful(),
                        _fieldWidgets(verifyOtpViewModel),  //  TODO  ::  ::  Need to remove the replace widget with otp 6 digit view
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: OTPTextField(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 60,
                            style: TextStyle(fontSize: 14),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        _submitButton(context, verifyOtpViewModel),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _progressBar(verifyOtpViewModel),
          ],
        ),
      ),
    );
  }
}
