import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:zzoopp_food/core/data/viewmodel/login_viewmodel.dart';
import 'package:zzoopp_food/ui/styles/colors.dart';
import 'package:zzoopp_food/ui/styles/custome_textField.dart';
import 'package:zzoopp_food/ui/styles/string_constants.dart';
import 'package:zzoopp_food/ui/styles/text_button_styles.dart';
import 'package:zzoopp_food/ui/styles/text_widget.dart';

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
  TextEditingController _emailController, _passwordController;
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
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FractionalTranslation(
                          translation: Offset(0.0, 0.9),
                          child: Image.asset(
                            "assets/images/img_logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hint: hintEmail,
                          icon: Icon(Icons.person),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: _passwordController,
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
                            RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
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
                              elevation: 2.0,
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
                              elevation: 2.0,
                              fillColor: AppColors.lightGreyColor,
                              child: Image.asset(
                                "assets/images/img_fb.png",
                                fit: BoxFit.contain,
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
            SizedBox(height: 20),

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
                        SizedBox(height: 30,)
                      ],
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              )),
        ],
      ),
    );
  }
}
