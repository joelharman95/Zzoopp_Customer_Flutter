class AppConstants {

  static String validateMobileOrEmail(String value) {
    String mobileNoPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    String emailPattern = r'(^(?:9)?[a-z][A-Z][0-9]@[a-z].[a-z]{2,3}$)';
    RegExp mobileNoRegExp = new RegExp(mobileNoPattern);
    RegExp emailRegExp = new RegExp(emailPattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!mobileNoRegExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

}
