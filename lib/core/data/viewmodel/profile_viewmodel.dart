
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';
import 'package:zzoopp_customer/ui/styles/constants.dart';

class ProfileViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  isFieldValid(BuildContext context) async {
    String message = "";
    if (nameController.text.isEmpty) {
      message = "Enter your name";
    } else if (phoneNoController.text.isEmpty) {
      message = "Enter your phone number";
    } else if (phoneNoController.text.isNotEmpty && !AppConstants.isMobileNoValid(phoneNoController.text)) {
      message = "Invalid phone number";
    } else if (emailController.text.isEmpty) {
      message = "Enter your email";
    } else if (emailController.text.isNotEmpty && !AppConstants.isEmailValid(emailController.text)) {
      message = "Invalid email address";
    } else if (addressController.text.isEmpty) {
      message = "Enter your address";
    }  else {
      message = "Success";
    }

    if (message.isNotEmpty) DialogService.of(context).showError(message);
    notifyListeners();
  }

  isMobileNoValid(BuildContext context) async {
    String message = "";
    if (phoneNoController.text.isEmpty) {
      message = "Enter your phone number";
    } else if (phoneNoController.text.isNotEmpty && !AppConstants.isMobileNoValid(phoneNoController.text)) {
      message = "Invalid phone number";
    } else {
      _verifyMobileOtp();
    }
    if (message.isNotEmpty) DialogService.of(context).showError(message);
    notifyListeners();
  }

  _verifyMobileOtp() async {

  }

  isEmailValid(BuildContext context) async {
    String message = "";
    if (emailController.text.isEmpty) {
      message = "Enter your email";
    } else if (emailController.text.isNotEmpty && !AppConstants.isEmailValid(emailController.text)) {
      message = "Invalid email address";
    } else {
      _verifyEmail();
    }
    if (message.isNotEmpty) DialogService.of(context).showError(message);
    notifyListeners();
  }

  _verifyEmail() async {

  }

  logout(BuildContext context) async {  //  Need to take callback from positive and negative button
    DialogService.of(context).showError("Sure want to logout");
    notifyListeners();
  }

}
