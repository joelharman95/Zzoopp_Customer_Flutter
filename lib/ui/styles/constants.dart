class AppConstants {
  static bool validateMobileOrEmail(String value) {
    if (isMobileNoValid(value)) {
      return true;
    } else if (isEmailValid(value)) {
      return true;
    }
    return false;
  }

  static bool isMobileNoValid(String value) {
    String mobileNoPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp mobileNoRegExp = new RegExp(mobileNoPattern);
    if (value.length == 0) {
      return false;
    } else if (!mobileNoRegExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static bool isEmailValid(String value) {
    String emailPattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp emailRegExp = new RegExp(emailPattern);
    if (value.length == 0) {
      return false;
    } else if (!emailRegExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
