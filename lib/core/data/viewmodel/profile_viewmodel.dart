
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
}
