/*
 * Created by Nethaji on 6/6/21 11:50 PM
 * And last updated by Nethaji on 6/6/21 11:50 PM
 */

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';

class ChangePwdViewModel extends BaseViewModel {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  isFieldValid(BuildContext context) async {
    String message = "";
    if (oldPasswordController.text.isEmpty) {
      message = "Old password cannot be empty";
    } else if (newPasswordController.text.isEmpty) {
      message = "New password cannot be empty";
    } else if (confirmPasswordController.text.isEmpty) {
      message = "Confirm password cannot be empty";
    }else if (confirmPasswordController.text != newPasswordController.text) {
      message = "New and confirm password must be same";
    } else {
      _changePassword();
    }
    if (message.isNotEmpty) DialogService.of(context).showError(message);
    notifyListeners();
  }

  _changePassword() async {

  }

}
