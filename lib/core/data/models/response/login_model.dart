import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class LoginModel {
  LoginModel();

  @JsonKey(name: 'is_customer_already_available') int isCustomerAlreadyAvailable;
  @JsonKey(name: 'otp_ref_id') int otpId;
  @JsonKey(name: 'customer') UserCustomerModel customer;
  @JsonKey(name: 'token') String token;
  @JsonKey(name: 'token_expiry_in_minutes') int tokenExpiryInMinutes;
  @JsonKey(name: 'created_at') String createdAt;

  @override
  List<Object> get props => [isCustomerAlreadyAvailable, otpId, customer, token, tokenExpiryInMinutes, createdAt];

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable(checked: true, explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class UserCustomerModel {
  UserCustomerModel();

  @JsonKey(name: 'id') int customerId;
  @JsonKey(name: 'owner_id') int ownerId;
  @JsonKey(name: 'first_name') String firstName;
  @JsonKey(name: 'last_name') String lastName;
  @JsonKey(name: 'mobile') String mobile;
  @JsonKey(name: 'email') String email;
  @JsonKey(name: 'is_mobile_verified') int isMobileVerified;
  @JsonKey(name: 'is_email_verified') int isEmailVerified;
  @JsonKey(name: 'address') String address;
  @JsonKey(name: 'description') String description;
  @JsonKey(name: 'profile_image') String profileImage;
  @JsonKey(name: 'latitude') double latitude;
  @JsonKey(name: 'longitude') double longitude;
  @JsonKey(name: 'country_id') int countryId;
  @JsonKey(name: 'state_id') int stateId;
  @JsonKey(name: 'city_id') int cityId;
  @JsonKey(name: 'postal_code') int postalCode;
  @JsonKey(name: 'anniversary') String anniversary;
  @JsonKey(name: 'dob') String dob;
  @JsonKey(name: 'account_number') int accountNumber;
  @JsonKey(name: 'taxable') int taxable;
  @JsonKey(name: 'created_at') String createdAt;
  @JsonKey(name: 'updated_at') String updatedAt;
  @JsonKey(name: 'deleted_at') String deletedAt;
  @JsonKey(name: 'is_hashed') int isHashed;
  @JsonKey(name: 'is_kyc_verified') int isKycVerified;
  @JsonKey(name: 'kyc_id') int kycId;

  @override
  List<Object> get props => [customerId, ownerId, firstName, lastName, mobile, email, isMobileVerified, isEmailVerified, address, description, profileImage, latitude, longitude, countryId, stateId, cityId, postalCode, anniversary, dob, accountNumber, taxable, createdAt, updatedAt, deletedAt, isHashed, isKycVerified, kycId];

  factory UserCustomerModel.fromJson(Map<String, dynamic> json) => _$UserCustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCustomerModelToJson(this);
}
