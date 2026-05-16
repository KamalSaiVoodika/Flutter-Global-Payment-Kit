const String kIConDir = 'assets/icons/';
const String kImageDir = 'assets/images/';
const String kFlagDir = 'assets/flags/';
const String kBase64Extend = 'data:image/jpeg;base64,';
const String kBase64ExtendVideo = 'data:video/mp4;base64,';
const String kBase64ExtendAudio = 'data:audio/mp3;base64,';

///Combined User Id to create single chatroom id
String combinedUserId(String id1, String id2) {
  return id1.compareTo(id2) > 0 ? '$id1-$id2' : '$id2-$id1';
}

const String kCurrency = '\$';
const String kName = 'Fozle Rabbi';
const String kEmail = 'fozlerabi.on@gmail.com';
const String kPhone = '8801796710416';
// Form Error
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp htmlValidatorRegExp = RegExp(r"(<[^>]*>|&\w+;)");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Your email address is not valid";
const String kPassNullError = "Please enter your password";
const String kPassNewNullError = "Please enter your New password";
const String kPassConfirmNullError = "Please enter your Confirm password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please enter your full name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kAddressNullError = "Please enter your address";
const String kInvalidNumberError = "Invalid phone number";
const String kMinWithdrawLimit = "Minimum withdraw limit 1 USD";
const String serverTimeoutMessage = "Request Time out. Please try again!";
/* //Stripe key
String kPublishableKey = 'pk_test_51KzxPNJ51wQ0UOOkIuXWdAOcFBXACfdGjQMF3KeU4E3ANq3KcSxnD5zCJVdzycgwDxHYpJGfxZga494XeY5ZYtjN00bjiwPTkn';
String kSecretKey = 'sk_test_51KzxPNJ51wQ0UOOk66cioh0gEdv9z8G2tqkP1I0dJW7tt65rZOzt2fk1jm5Re60dCOIrMn4wXTSjoDLBjDkDWdma007PPn4JBu';
//Paypal credential
String kPaypalClientId = "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0";
String kPaypalSecretKey = "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9";
//PayStack credential
String kPayStackPublicKey = 'pk_test_d6c9db1c01e54ef274b80c6c5138bcdad41da3c3';
//Flutter wave credential
String kWavePublicKey = 'FLWPUBK_TEST-b100340af976af485842813badb813b9-X';
String kWaveSecretKey= 'FLWSECK_TEST-d0a5f60a8bf8f7bb7ac05ca75867a0c0-X';
String kWaveEncryptionKey= 'FLWSECK_TESTb007f3a37e82';
const String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j'; */

///****Don't change***
const String topicName = 'web_app';
const int timeoutRequest = 60;
// Shared Key
const String theme = 'theme';
const String token = 'theme';

///****Don't change end***
//Image show and hide
const bool isImageShow = true;

const String kPrivacyPolices = "";

const String kTermsConditions = "";
