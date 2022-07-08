// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/config/appColors.dart';
import '/config/sizeConfig.dart';
import '/config/textStyles.dart';

class CustomElevatedButton {
  static elevatedButton({onPressed, title, Color ? color,TextStyle ? textStyle}) {
    return ElevatedButton(
        onPressed: onPressed,
        
        style: ElevatedButton.styleFrom(
          
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.screenWidth! * .03),
          minimumSize: Size(SizeConfig.screenWidth! * 1, 50),
          primary: color ?? AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: color ?? AppColors.kPrimaryColor,width: 0.5),
              borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(title, style: textStyle ?? h4WhiteSemiBold));
  }

  static benificiaryButton({required onPressed,}){
    return InkWell(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.lightGreyBg,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add Beneficiary",
                  style: h3BlackBold.copyWith(
                    color: AppColors.kPrimaryColor,
                  )),
              SvgPicture.asset("assets/images/plus-icon.svg")
            ],
          )),
    );
  }

   static borderedButton({onPressed, title, color}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.screenWidth! * .03),
          minimumSize: Size(SizeConfig.screenWidth! * 1, 50),
          primary: Colors.white,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.kPrimaryColor, width: 3),
              borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(title,
            style: h3BlackSemiBold.copyWith(color: AppColors.kPrimaryColor)));
  }
}
