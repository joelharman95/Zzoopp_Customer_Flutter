// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('LoginModel', json, () {
    final val = LoginModel();
    $checkedConvert(json, 'is_customer_already_available', (v) => val.isCustomerAlreadyAvailable = v as int);
    $checkedConvert(json, 'otp_ref_id', (v) => val.otpId = v as int);
    $checkedConvert(json, 'customer', (v) => val.customer = v == null ? null : UserCustomerModel.fromJson(v as Map<String, dynamic>));
    $checkedConvert(json, 'token', (v) => val.token = v as String);
    $checkedConvert(json, 'token_expiry_in_minutes', (v) => val.tokenExpiryInMinutes = v as int);
    $checkedConvert(json, 'created_at', (v) => val.createdAt = v as String);
    return val;
  }, fieldKeyMap: const {
    'isCustomerAlreadyAvailable': 'is_customer_already_available',
    'otpId': 'otp_ref_id',
    'tokenExpiryInMinutes': 'token_expiry_in_minutes',
    'createdAt': 'created_at'
  });
}

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('is_customer_already_available', instance.isCustomerAlreadyAvailable);
  writeNotNull('otp_ref_id', instance.otpId);
  writeNotNull('customer', instance.customer?.toJson());
  writeNotNull('token', instance.token);
  writeNotNull('token_expiry_in_minutes', instance.tokenExpiryInMinutes);
  writeNotNull('created_at', instance.createdAt);
  return val;
}

UserCustomerModel _$UserCustomerModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('UserCustomerModel', json, () {
    final val = UserCustomerModel();
    $checkedConvert(json, 'id', (v) => val.customerId = v as int);
    $checkedConvert(json, 'owner_id', (v) => val.ownerId = v as int);
    $checkedConvert(json, 'first_name', (v) => val.firstName = v as String);
    $checkedConvert(json, 'last_name', (v) => val.lastName = v as String);
    $checkedConvert(json, 'mobile', (v) => val.mobile = v as String);
    $checkedConvert(json, 'email', (v) => val.email = v as String);
    $checkedConvert(json, 'is_mobile_verified', (v) => val.isMobileVerified = v as int);
    $checkedConvert(json, 'is_email_verified', (v) => val.isEmailVerified = v as int);
    $checkedConvert(json, 'address', (v) => val.address = v as String);
    $checkedConvert(json, 'description', (v) => val.description = v as String);
    $checkedConvert(json, 'profile_image', (v) => val.profileImage = v as String);
    $checkedConvert(json, 'latitude', (v) => val.latitude = (v as num)?.toDouble());
    $checkedConvert(json, 'longitude', (v) => val.longitude = (v as num)?.toDouble());
    $checkedConvert(json, 'country_id', (v) => val.countryId = v as int);
    $checkedConvert(json, 'state_id', (v) => val.stateId = v as int);
    $checkedConvert(json, 'city_id', (v) => val.cityId = v as int);
    $checkedConvert(json, 'postal_code', (v) => val.postalCode = v as int);
    $checkedConvert(json, 'anniversary', (v) => val.anniversary = v as String);
    $checkedConvert(json, 'dob', (v) => val.dob = v as String);
    $checkedConvert(json, 'account_number', (v) => val.accountNumber = v as int);
    $checkedConvert(json, 'taxable', (v) => val.taxable = v as int);
    $checkedConvert(json, 'created_at', (v) => val.createdAt = v as String);
    $checkedConvert(json, 'updated_at', (v) => val.updatedAt = v as String);
    $checkedConvert(json, 'deleted_at', (v) => val.deletedAt = v as String);
    $checkedConvert(json, 'is_hashed', (v) => val.isHashed = v as int);
    $checkedConvert(json, 'is_kyc_verified', (v) => val.isKycVerified = v as int);
    $checkedConvert(json, 'kyc_id', (v) => val.kycId = v as int);
    return val;
  }, fieldKeyMap: const {
    'customerId': 'id',
    'ownerId': 'owner_id',
    'firstName': 'first_name',
    'lastName': 'last_name',
    'isMobileVerified': 'is_mobile_verified',
    'isEmailVerified': 'is_email_verified',
    'profileImage': 'profile_image',
    'countryId': 'country_id',
    'stateId': 'state_id',
    'cityId': 'city_id',
    'postalCode': 'postal_code',
    'accountNumber': 'account_number',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'deletedAt': 'deleted_at',
    'isHashed': 'is_hashed',
    'isKycVerified': 'is_kyc_verified',
    'kycId': 'kyc_id'
  });
}

Map<String, dynamic> _$UserCustomerModelToJson(UserCustomerModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.customerId);
  writeNotNull('owner_id', instance.ownerId);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('mobile', instance.mobile);
  writeNotNull('email', instance.email);
  writeNotNull('is_mobile_verified', instance.isMobileVerified);
  writeNotNull('is_email_verified', instance.isEmailVerified);
  writeNotNull('address', instance.address);
  writeNotNull('description', instance.description);
  writeNotNull('profile_image', instance.profileImage);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('country_id', instance.countryId);
  writeNotNull('state_id', instance.stateId);
  writeNotNull('city_id', instance.cityId);
  writeNotNull('postal_code', instance.postalCode);
  writeNotNull('anniversary', instance.anniversary);
  writeNotNull('dob', instance.dob);
  writeNotNull('account_number', instance.accountNumber);
  writeNotNull('taxable', instance.taxable);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  writeNotNull('deleted_at', instance.deletedAt);
  writeNotNull('is_hashed', instance.isHashed);
  writeNotNull('is_kyc_verified', instance.isKycVerified);
  writeNotNull('kyc_id', instance.kycId);
  return val;
}
