import 'package:fluttertoast/fluttertoast.dart';
import '/config/appColors.dart';

class Validations {
  static showToast(String mesg) {
    return Fluttertoast.showToast(
        msg: mesg,
        textColor: AppColors.white,
        backgroundColor: AppColors.kPrimaryColor,
        fontSize: 14);
  }

  static emailValidator(value) {
    if (value!.isEmpty) {
      return 'Please Enter Email';
    }
    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value)) {
      return 'Email Format is invalid';
    } else {
      return null;
    }
  }


  static aadharNumberValidate(String value) {
    if (value.isEmpty) {
      return 'Please Enter Aadhar/Mobile Number';
    }

    if (value.length < 10) {
      return 'Mobile number is invalid';
    } else if (value.length == 11 || value.length > 12) {
      return "Aadhar number is invalid";
    } else {
      return null;
    }
  }

  static mobileValidate(String value) {
    if (value.isEmpty) {
      return 'Please Enter Mobile Number';
    }

    if (value.length < 10) {
      return 'Mobile number is invalid';
    } else {
      return null;
    }
  }

  static aadharValidate(String value) {
    if (value.isEmpty) {
      return 'Please Enter Aadhar Number';
    }

    if (value.length < 12) {
      return "Aadhar number is invalid";
    } else {
      return null;
    }
  }

  static securityPinValidate(String value) {
    if (value.isEmpty) {
      return 'Please Enter your PIN';
    }

    if (value.length !=6) {
      return 'PIN is incorrect';
    } else {
      return null;
    }
  }

   static validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please Enter password';
    }

    if (value.length < 6) {
      return 'password should be alteast 6 charectors';
    } else {
      return null;
    }
  }

  static commonValidate({String? value, String? title}) {
    if (value!.isEmpty) {
      return 'Please Enter $title';
    } else {
      return null;
    }
  }
}
