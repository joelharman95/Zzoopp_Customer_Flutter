import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_customer/core/data/viewmodel/login_viewmodel.dart';
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
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/img_bg.png",
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.7,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FractionalTranslation(
                          translation: Offset(0.0, 0.7),
                          child: Image.asset(
                            "assets/images/img_logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/1.9,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: viewModel.userNameController,
                            hint: hintEmail,
                            icon: Icon(Icons.person),
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: viewModel.passwordController,
                            hint: hintPassword,
                            icon: Icon(Icons.lock),
                            obsecure: true,
                          ),
                          Row(
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
                                  onTap: () {},
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
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 37,
                                width: 120,
                                child: TextButton(
                                    onPressed: () {
                                      viewModel.loginValidation(context);
                                    },
                                    style: TextButtonStyles.getTextButtonStyle(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  child: TextWidget(
                                    text: login,
                                    size: 16,
                                    weight: FontWeight.w400,
                                    color: AppColors.lightBackgroundColor,
                                  )
                                   ),
                              ),
                              Container(width: 170,)
                            ],
                          ),
                          SizedBox(height: 30),
                          TextWidget(
                            text: loginWith,
                            size: 14,
                            weight: FontWeight.w600,
                            color: AppColors.darkBackgroundColor,
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInButton(
                                Buttons.Facebook,
                                mini: true,
                                onPressed: () {},
                              ),SignInButton(
                                Buttons.Google,
                                onPressed: () {},
                              ),SignInButton(
                                Buttons.Apple,
                                mini: true,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          RichText(
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
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: viewModel.isBusy,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              )),
        ],
      ),
    );
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
