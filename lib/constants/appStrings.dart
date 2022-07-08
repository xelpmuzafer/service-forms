// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import '/config/textStyles.dart';

class ConstantStrings {
  static const String BASE_URL = "http://49.50.74.106:3003";

  static const String GOOGLE_API = "AIzaSyC-uNLo0s67-B5i1ncDTE6w0Ea1i6rU6Go";

  static const String tokens = "tokens";

  static const String accessToken = "accessToken";

  // static const String ulbs = "ULB";

  static const String ids = "ids";

  //  static const String ulbId = "ulbId";

  static const String citizenId = "citizenId";

  static const String onBoard = "onBoard";

  static const String onBoarded = "onBoarded";

  static const String customData = "customData";

  static const String mobileNumber = "mobileNumber";

  static const String contactUs_Url = "https://cgmitaan.in/#contactSection";
  static const String aboutUs_Url = "https://cgmitaan.in/#aboutSection";
  static const String faq_Url = "https://cgmitaan.in/#faqSection";
}

class AppStrings {
  static const String appName = "MITAAN";
  static const String mobileNumber = "Mobile Number";
  static const String signIntitle = "Sign In to your account here..";
  static const String forgotPasswordtitle = "Forgot password?";
    static const String newPasswordTitle = "Enter new password";

  static const String sendOtpInfo =
      "We need to send OTP to aunthenticate your number.";
  static String verifyOtpInfo(String mobileNumber) =>
      "Mitaan app has sent you an OTP to your registered mobile (xxxxxx${mobileNumber.toString().substring((mobileNumber.toString().length - 4), mobileNumber.toString().length)})";

  static const String phoneNumber = "Phone Number";
  static const String aadharMobile = "Aadhaar/ Mobile Number*";
  static const String sendOtp = "Send OTP";
  static const String verifyOtp = "Verify OTP";
  static const String enterOtp = "Enter OTP";
  static const String termsConditions = "Terms & Conditions";
  static const String termsInfo = "By signing in, you are agreeing with our";

  static const String otp = "OTP";

  static const String resendOtp = "Resend OTP";

  static const String singIn = "Sign In";

  static const String setPinInfo = "Set 6 digit security PIN *";
  static const String enterPinInfo = "Enter 6 digit security PIN *";

  static const String enterPin = "Enter your PIN";

  static const String forgotPin = "Forgot security PIN?";

  static const String signUpInfo = "Do not have an account?";

  static const String backTOSign = "go back to";

  static const String signUp = "Sign Up";

  static const String otpVerifyTitle = "OTP Verification";

  static const String resendOtpInfo = "Did not get the OTP?";

  static const String signUpTitle = "Create your account here..";

  static const String fullName = "Full Name (As per Aadhaar)";

  static const String mobileNumberHint = "Enter your mobile number";

  static const String dobHint = "DD | MM | YYYY";

  static const String dobLabel = "Date of birth (as per aadhaar)";

  static const String emailHint = "Enter your valid email ID";

  static const String emailId = "Email ID";

  static const String aadharHint = "Enter your Aadhaar";

  static const String aadharNumber = "Aadhaar Number";

  static const String proceed = "Proceed";

  static const String alreadyAc = "Already have account?";

  static const String signIn = "Sign In";

  static const String submit = "Submit";
  static const String appliedTitle = "Applied Services";

  static const String paymentStatus = "Payment Status";

  static const String notifications = "Notifications";

  static const String firstName = "First name";

  static const String lastName = "Last name";

  static const String firstNameAadhar = "First name (As per Aadhar)";

  static const String lastNameAadhar = "Last name (As per Aadhar)";

  static const String initial = "Initials";

  static const String altMobile = "Alternate mobile number";
  static const String emailAddres = "Email address";
  static const String address = "Address Line";
  static const String village = "Village/City";
  static const String pinCode = "PIN Code";
  static const String ulb = "ULB";
  static const String wardNumber = "Ward number";
  static const String appliedServices = " Applied Services";

  static const String isLogOut = "Are you sure you want to logout ?";

  static const String docsReq = "List of Documents required";

  static const String docsReqInfo =
      "Please book a slot only when you have the documents listed below ready.";

  static const String passwordHint = "Please enter pasword";

  static const String Password = "Password";

  static const String onBoardingInfoOne =
      "Dial 14545 (Toll free)and book\nyourslot to avail the service";
  static const String onBoardingInfoTwo =
      "Provide required documents to\nour mitaan agent for applied\nservices";

  static const String onBoardingInfoThree =
      "Get your certificate at your\ndoor-step by Mitaan";

  static const String male = "Male";

  static const String female = "Female";

  static const String other = "Other";
}

class AssetPath {
  static const String mitaanLogo = "assets/images/mitaanLogo.svg";
  static const String mobileIcon = "assets/images/Icon metro-mobile.svg";
  static const String callIcon = "assets/images/phoneIcon.svg";
  static const String marriageCertificateIcon =
      "assets/images/marrige-certificate.svg";
  static const String agentIcon = "assets/images/agentIcon.png";
  static const String verifiedIcon = "assets/images/verified.svg";
  static const String calenderIcon = "assets/images/calenderIcon.svg";
  static const String clockIcon = "assets/images/clockIcon.svg";
  static const String alertIcon = "assets/images/alert-circle.svg";
  static const String waitingIcon = "assets/images/waitingIcon.svg";
  static const String dailerIcon = "assets/images/dialerIcon.svg";
  static const String appliedIcon = "assets/images/appliedIcon.png";
  static const String deliveryIcon = "assets/images/deliveryIcon.svg";
   static const String dashboardIcon = "assets/images/dashboardIcon.svg";
  static const String documentIcon = "assets/images/documentIcon.svg";
  static const String dialorIcon = "assets/images/dialorIcon.svg";
  static const String chatInfoIcon = "assets/images/chatInfoIcon.svg";
  static const String birdIcon = "assets/images/Mitaan Bird with Leaf.svg";
}

class ErrorMsgs {
  static const String serverError = "Internal Server Error";

  static String notFound = "Not Found";

  ErrorMsgs._();
  static const String unauthorized = "Session Time Out";
  static const String badRequest = "Bad Request";
  static const String noInternet = "Please Check Your Internet Connection";
  static const String serverUnavailable =
      "Problem connecting to the server. Please try again.";
  static const String socketException = "Socket Exception";

  static showError({String? errorMesg, double? height}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/no-data.png",
            width: 100,
            height: height ?? 60,
          ),
          TextButton(
            child: Text(
              errorMesg ?? "No data found",
              style: h4Black.copyWith(fontWeight: FontWeight.w600),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
