import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/data/viewmodel/login_viewmodel.dart';
import 'package:zzoopp_customer/ui/screens/register_screen.dart';
import 'package:zzoopp_customer/ui/screens/verify_otp_screen.dart';
import 'package:zzoopp_customer/ui/styles/colors.dart';
import 'package:zzoopp_customer/ui/styles/custome_textField.dart';
import 'package:zzoopp_customer/ui/styles/string_constants.dart';
import 'package:zzoopp_customer/ui/styles/text_button_styles.dart';
import 'package:zzoopp_customer/ui/styles/text_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (LoginViewModel model) {},
      builder: (context, LoginViewModel model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: _LoginView(),
      ),
      viewModelBuilder: () => LoginViewModel(),
      disposeViewModel: false,
    );
  }
}
class _LoginView extends ViewModelWidget<LoginViewModel> {
  bool isRemember = false;

  @override
  Widget build(BuildContext context, LoginViewModel loginViewModel) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  _bannerImage(context),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Container(height: height/4.1,),
                        _logo(context),
                        SizedBox(height: 30,),

                        _fieldWidgets(loginViewModel),
                        _forgotPasswordWidget(context,loginViewModel),
                        _submitButton(context, loginViewModel),
                        SizedBox(height: 20,),
                        _loginWith(),
                        SizedBox(height: 10,),
                        _signUpButton(context),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _progressBar(loginViewModel),
          ],
        ),
      ),
    );

  }

  Widget _submitButton(BuildContext context, LoginViewModel loginViewModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          loginViewModel.loginValidation(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()),);
        },
        style: TextButtonStyles.getTextButtonStyle(
          padding: EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child:TextWidget(
          text: login,
          size: 14,
          fontStyle: FontStyle.normal,
          weight: FontWeight.w600,
          color: AppColors.lightBackgroundColor,
        ),
      ),
    );
  }
Widget _loginWith(){
 return Column(
   children: [
     TextWidget(
      text: loginWith,
      size: 14,
      weight: FontWeight.w600,
      color: AppColors.darkBackgroundColor,
      ),
     SizedBox(height: 10),
     Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         RawMaterialButton(
           onPressed: () {},
           elevation: 1.0,
           fillColor: AppColors.lightGreyColor,
           child: Image.asset(
             "assets/images/img_fb.png",
             fit: BoxFit.contain,
           ),
           padding: EdgeInsets.all(15.0),
           shape: CircleBorder(),
         ),
         RawMaterialButton(
           onPressed: () {},
           elevation: 1.0,
           fillColor: AppColors.lightGreyColor,
           child: Image.asset(
             "assets/images/img_google.png",
             fit: BoxFit.contain,
           ),
           padding: EdgeInsets.all(15.0),
           shape: CircleBorder(),
         ),
         RawMaterialButton(
           onPressed: () {},
           elevation: 1.0,
           fillColor: AppColors.lightGreyColor,
           child: Image.asset(
             "assets/images/img_apple.png",
             fit: BoxFit.contain,
           ),
           padding: EdgeInsets.all(15.0),
           shape: CircleBorder(),
         ),
       ],
     ),
   ],
 );

}
  Widget _progressBar(LoginViewModel loginViewModel) {
    return Visibility(
        visible: loginViewModel.isBusy,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ));
  }

  Future getAppleIDCredential() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(credential);
    // Need to send the credential to server
    return credential;
  }

  Widget _bannerImage(BuildContext context) {
    return Image.asset("assets/images/img_bg.png",
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.7,
    );
  }
  Widget _logo(BuildContext context) {
    return Image.asset(
      "assets/images/img_logo.png",
      fit: BoxFit.contain,
    );
  }
  Widget _entryField(String title, TextEditingController controller, Icon icon, TextInputType textInputType, TextInputAction textInputAction, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CustomTextField(
        controller: controller,
        hint: title,
        icon: icon,
        obsecure: isPassword,
        textInputType: textInputType,
        textInputAction:  textInputAction,
        // isReadOnly : true,
      ),
    );
  }
  Widget _fieldWidgets(LoginViewModel loginViewModel) {

    return Column(
      children: <Widget>[
        _entryField("UserName", loginViewModel.userNameController, Icon(Icons.email_outlined), TextInputType.emailAddress, TextInputAction.next),
        _entryField("Password", loginViewModel.passwordController, Icon(Icons.lock), TextInputType.visiblePassword, TextInputAction.next, isPassword: true),
      ],
    );

  }
  _forgotPasswordWidget(BuildContext context, LoginViewModel loginViewModel) {
   return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Checkbox(
                value: this.isRemember,
                onChanged: (bool value) {
                  // setState(() {
                  //   this.value = value;
                  // });
                },
              ),
              TextWidget(
                text: rememberMe,
                size: 14,
                weight: FontWeight.w400,
                color: AppColors.greyColor,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen()),);

            },
            child: TextWidget(
              text: forgetPassword,
              size: 14,
              fontStyle: FontStyle.italic,
              weight: FontWeight.w400,
              color: AppColors.greyColor,
            ),
          ),
        )
      ],
    );
  }

  _signUpButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()),);
      },
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text:newUser,
                style: GoogleFonts.openSans(
                    color: AppColors.greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: signUp,
                style: GoogleFonts.nunito(
                    color: AppColors.primaryColor,
                    fontSize:12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );

  }

/*Future<FirebaseUser> signInWithApple() async {
    var redirectURL = "https://SERVER_AS_PER_THE_DOCS.glitch.me/callbacks/sign_in_with_apple";
    var clientID = "AS_PER_THE_DOCS";
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID,
            redirectUri: Uri.parse(
                redirectURL)));
    final oAuthProvider = OAuthProvider(providerId: 'apple.com');
    final credential = oAuthProvider.getCredential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );
    final authResult =
    await SignInUtil.firebaseAuth.signInWithCredential(credential);
    return authResult.user;
  }*/

}
