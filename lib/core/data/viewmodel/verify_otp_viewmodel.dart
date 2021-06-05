/*
 * Created by Nethaji on 5/6/21 12:50 PM
 * And last updated by Nethaji on 5/6/21 12:50 PM
 */

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';

class VerifyOtpViewModel extends BaseViewModel {
  TextEditingController optController = TextEditingController();

  isFieldValid(BuildContext context) async {
    String message = "";
    if (optController.text.isEmpty) {
      message = "Enter your name";
    } else if (optController.text.length != 6) {
      message = "Enter a valid otp";
    } else {
      //  TODO  ::  ::  API call here
    }
    if (message.isNotEmpty) DialogService.of(context).showError(message);
    notifyListeners();
  }
}
