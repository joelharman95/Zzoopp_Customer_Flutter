/*
 * Created by Nethaji on 5/6/21 12:50 PM
 * And last updated by Nethaji on 5/6/21 12:50 PM
 */

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';
import 'package:zzoopp_customer/ui/styles/constants.dart';

class VerifyOtpViewModel extends BaseViewModel {
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController optController = TextEditingController();

  isFieldValid(BuildContext context) async {
    String message = "";
    if (phoneNoController.text.isEmpty) {
      message = "Enter your registered email or mobile number";
    } else {
      if (AppConstants.isText(phoneNoController.text)) {
        if (!AppConstants.isEmailValid(phoneNoController.text)) {
          message = "Invalid email address";
        } else {
          message = _isOtpValid("email address");
          if(message.isEmpty) {
            _verifyOtp(false);
          }
        }
      } else if (!AppConstants.isMobileNoValid(phoneNoController.text)) {
        message = "Invalid phone number";
      }  else {
        message = _isOtpValid("mobile number");
        if(message.isEmpty) {
          _verifyOtp(true);
        }
      }
    }
    if (message.isNotEmpty) DialogService.of(context).showError(message);
    notifyListeners();
  }

  String _isOtpValid(String error) {
    String message = "";
    if (optController.text.isEmpty) {
      message = "Enter your One time password send to your $error";
    } else if (optController.text.length != 6) {
      message = "Enter a valid otp";
    }
    return message;
  }

  _verifyOtp(bool isMobileNo) async {

  }

}
