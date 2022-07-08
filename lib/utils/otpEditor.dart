// ignore_for_file: file_names, prefer_const_constructors, prefer_is_empty
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/config/appColors.dart';
import '/config/textStyles.dart';

class OtpEditor extends StatelessWidget {
  const OtpEditor({Key? key, this.code, this.first, this.last})
      : super(key: key);
  final TextEditingController? code;

  final bool? first;
  final bool? last;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.phone,
        
        controller: code,
        cursorColor: AppColors.kPrimaryColor,
        maxLength: 1,
        style: h3BlackSemiBold,
        decoration: InputDecoration(
          counterText: '',
          contentPadding:const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.kPrimaryColor, width: 2.0),
          ),
        ));
  }
}
