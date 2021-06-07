
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';
import 'package:zzoopp_customer/ui/styles/constants.dart';

class ProfileViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  DateTime date = DateTime.parse("2019-04-16 12:18:06.018950");

  isFieldValid(BuildContext context) async {
    String message = "";
    if (nameController.text.isEmpty) {
      message = "Enter your name";
    } else if (phoneNoController.text.isEmpty) {
      message = "Enter your phone number";
    } else if (phoneNoController.text.isNotEmpty && !AppConstants.isMobileNoValid(phoneNoController.text)) {
      message = "Invalid phone number";
    }else if (altPhoneNoController.text.isNotEmpty && !AppConstants.isMobileNoValid(altPhoneNoController.text)) {
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

   isDatePicker(BuildContext context) async{
     SystemChannels.textInput.invokeMethod('TextInput.hide');

     date = await showDatePicker(
         context: context,
         initialDate: DateTime.now(),
         firstDate: DateTime(1900),
         lastDate: DateTime(2022));
     String dateFormat =
     DateFormat(" d-MMMM-y").format(date);
     dateOfBirthController.text = dateFormat;

  }

}
