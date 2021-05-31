import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_food/app/locator.config.dart';
import 'package:zzoopp_food/app/routes/routes.dart';
import 'package:zzoopp_food/core/basics/abstract/storage_service_interface.dart';
import 'package:zzoopp_food/core/data/models/response/login_model.dart';
import 'package:zzoopp_food/core/data/resources/api/clients/login_api.dart';
import 'package:zzoopp_food/core/data/resources/api/response/api_response.dart';
import 'package:zzoopp_food/core/data/resources/storage/storage_keys.dart';
import 'package:zzoopp_food/core/service/dialog.service.dart';
import 'package:zzoopp_food/ui/styles/constants.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController mobileTextEditingcontroller = TextEditingController();
  TextEditingController otpTextEditingcontroller = TextEditingController();
  bool isOtp = false;
  FocusNode mobileFocus = FocusNode();
  FocusNode otpFocus = FocusNode();
  bool isCheckBox = false;
  LoginModel loginModel;

  loginValidation(BuildContext context) async {
    String message = "";

    if (isOtp) {
      if (isCheckBox) {
        if (otpTextEditingcontroller.text.isNotEmpty &&
            otpTextEditingcontroller.text.length == 6) {
          otpFocus.unfocus();
          await sendOtpLoginRegisterApi(mobileTextEditingcontroller.text,
              otp: otpTextEditingcontroller.text, context: context);
        } else if (otpTextEditingcontroller.text.isEmpty) {
          message = "Enter OTP";
        } else {
          message = "The entered OTP is invalid.";
        }
      } else {
        message = "Please accept the Terms of Services & Privacy Policies";
      }
    } else {
      if (AppConstants.validateMobile(mobileTextEditingcontroller.text) ==
          null) {
        if (isCheckBox) {
          await sendOtpLoginRegisterApi(mobileTextEditingcontroller.text,
              context: context);
        } else {
          message = "Please accept the Terms of Services & Privacy Policies";
        }
      } else {
        message = "Please enter a valid mobile number";
      }
    }
    if (message.isNotEmpty) DialogService.of(context).showError(message);

    notifyListeners();
  }

  checkBoxUpdate(bool value) {
    isCheckBox = value;
    notifyListeners();
  }

  sendOtpLoginRegisterApi(String mobileNumber,
      {String otp, BuildContext context}) async {
    setBusy(true);
    try {
      ApiResponse response = await locator<LoginApi>().sendLoginOtp(mobileNumber, otp);
      if (response.succeed) {
        Map<String, dynamic> data = response.json['data'];
        loginModel = LoginModel.fromJson(data);

        otpFocus.requestFocus();
        if (loginModel.isCustomerAlreadyAvailable == 0) {
          mobileFocus.unfocus();
          /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterScreen(
                    isOtp: true,
                    mobileNumber: mobileTextEditingcontroller.text)),
          );*/
        } else {
          isOtp = true;
        }
        if (otp != null) {
          StorageServiceInterface storageServiceInterface =
              locator<StorageServiceInterface>();
          storageServiceInterface.save(
              StorageKey.token, loginModel.token);
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home, (Route<dynamic> route) => false);
        }
      } else {
        final message = response?.errorMessage;
        DialogService.of(context).showError(message);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    setBusy(false);
  }

  resendOtpLoginAndRegisterApi(String mobileNumber,
      {String referOtp, BuildContext context}) async {
    setBusy(true);
    try {
      ApiResponse response = await locator<LoginApi>()
          .resendOtpLoginAndRegister(mobileNumber, referOtp);
      if (response.succeed) {
        Map<String, dynamic> data = response.json['data'];
        loginModel = LoginModel.fromJson(data);
      } else {
        final message = response?.errorMessage;
        DialogService.of(context).showError(message);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    setBusy(false);
  }
}
