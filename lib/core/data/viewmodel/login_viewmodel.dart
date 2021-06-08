import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/app/locator.config.dart';
import 'package:zzoopp_customer/app/routes/routes.dart';
import 'package:zzoopp_customer/core/basics/abstract/storage_service_interface.dart';
import 'package:zzoopp_customer/core/data/models/response/login_model.dart';
import 'package:zzoopp_customer/core/data/resources/api/clients/login_api.dart';
import 'package:zzoopp_customer/core/data/resources/api/response/api_response.dart';
import 'package:zzoopp_customer/core/data/resources/storage/storage_keys.dart';
import 'package:zzoopp_customer/core/service/dialog.service.dart';
import 'package:zzoopp_customer/ui/screens/profile_screen.dart';
import 'package:zzoopp_customer/ui/styles/constants.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isOtp = false;
  FocusNode mobileFocus = FocusNode();
  FocusNode otpFocus = FocusNode();
  bool isCheckBox = false;
  LoginModel loginModel;

  GoogleSignIn _googleSignIn = GoogleSignIn();

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

  /*  Nethaji's SHA
  SHA1: 60:4C:08:3B:CD:A9:E4:03:70:3D:30:C2:CF:F6:B6:C8:41:C5:28:FF
  SHA-256: 02:C2:B1:74:FC:5D:76:23:AB:0A:4A:7B:51:C8:03:59:D7:15:F5:26:D5:FB:A4:55:79:FB:6A:45:CA:B1:F4:DB
  * */
  /*  Gayathri's SHA

  * */
   googleLogin(BuildContext context) async {
     setBusy(true);
     /*if(_googleSignIn.currentUser != null) {
       _googleSignIn.signOut();
     }*/
     _googleSignIn.signIn().then((userData) {
         print('GET______' + userData.email);
         print('GET______' + userData.displayName);
         print('GET______' + userData.photoUrl);
         notifyListeners();
         setBusy(false);
    }).catchError((e) {
       print('Exception   ' + e);
       notifyListeners();
       setBusy(false);
     });
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
