import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/app/locator.config.dart';
import 'package:zzoopp_customer/app/routes/routes.dart';
import 'package:zzoopp_customer/core/basics/abstract/storage_service_interface.dart';
import 'package:zzoopp_customer/core/data/models/response/login_model.dart';
import 'package:zzoopp_customer/core/data/resources/api/clients/login_api.dart';
import 'package:zzoopp_customer/core/data/resources/api/response/api_response.dart';
import 'package:zzoopp_customer/core/data/resources/storage/storage_keys.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';
import 'package:zzoopp_customer/ui/styles/constants.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isOtp = false;
  FocusNode mobileFocus = FocusNode();
  FocusNode otpFocus = FocusNode();
  bool isCheckBox = false;
  LoginModel loginModel;

  loginValidation(BuildContext context) async {
    String message = "";

    if (isOtp) {
      if (isCheckBox) {
        if (passwordController.text.isNotEmpty && passwordController.text.length == 6) {
          otpFocus.unfocus();
          await sendOtpLoginRegisterApi(userNameController.text, otp: passwordController.text, context: context);
        } else if (passwordController.text.isEmpty) {
          message = "Enter your password";
        } else {
          message = "Your password is invalid.";
        }
      } else {
        message = "Please accept the Terms of Services & Privacy Policies";
      }
    } else {
      if (!AppConstants.validateMobileOrEmail(userNameController.text)) {
        if (isCheckBox) {
          await sendOtpLoginRegisterApi(userNameController.text, context: context);
        } else {
          message = "Please accept the Terms of Services & Privacy Policies";
        }
      } else {
        message = "Please enter your registered mobile number or email address";
      }
    }
    if (message.isNotEmpty) DialogService.of(context).showError(message);

    notifyListeners();
  }

  checkBoxUpdate(bool value) {
    isCheckBox = value;
    notifyListeners();
  }

  sendOtpLoginRegisterApi(String mobileNumber, {String otp, BuildContext context}) async {
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
                    mobileNumber: userNameController.text)),
          );*/
        } else {
          isOtp = true;
        }
        if (otp != null) {
          StorageServiceInterface storageServiceInterface = locator<StorageServiceInterface>();
          storageServiceInterface.save(StorageKey.token, loginModel.token);
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
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

  resendOtpLoginAndRegisterApi(String mobileNumber, {String referOtp, BuildContext context}) async {
    setBusy(true);
    try {
      ApiResponse response = await locator<LoginApi>().resendOtpLoginAndRegister(mobileNumber, referOtp);
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
