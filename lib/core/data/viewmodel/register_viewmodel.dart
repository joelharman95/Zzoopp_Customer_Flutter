/*
 * Created by Nethaji on 5/6/21 10:02 AM
 * And last updated by Nethaji on 5/6/21 10:02 AM
 */

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';
import 'package:zzoopp_customer/ui/styles/constants.dart';

class RegisterViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
    } else if (passwordController.text.isEmpty) {
      message = "Enter your password";
    } else if (confirmPasswordController.text.isEmpty) {
      message = "Enter your confirm password";
    } else if (passwordController.text != confirmPasswordController.text) {
      message = "Your new password and confirm password not matching";
    } else {
      message = "Success";
    }

    if (message.isNotEmpty) DialogService.of(context).showError(message);
    notifyListeners();
  }
}
