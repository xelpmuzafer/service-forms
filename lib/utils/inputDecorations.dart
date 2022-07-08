// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import '/config/appColors.dart';
import '/config/textStyles.dart';

InputDecoration customInputDecoration({required String  hintText, String ? labeltext,}) {
  return InputDecoration(
      hintText: hintText,
      counterText: "",
      labelText: labeltext ?? hintText,
      
      labelStyle: h6Black.copyWith(fontSize: 8,color: AppColors.textBlackThin),
      fillColor: AppColors.white,
      hintStyle: h5BlackLight.copyWith(color: AppColors.lightGrey),
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.thinGrey,
            width: 0.5,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.thinGrey,
            width: 0.5,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.thinGrey,
            width: 0.5,
          )));
}

InputDecoration customFormFields({required String  hintText,}) {
  return InputDecoration(
      hintText: hintText,
      counterText: "",
      labelStyle: h6BlackLight.copyWith(fontSize: 8),
      fillColor: AppColors.white,
      hintStyle: h3Black.copyWith(color: AppColors.lightText.withOpacity(0.56)),
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(
            color: AppColors.thinGrey,
            width: 0.5,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(
            color: AppColors.thinGrey,
            width: 0.5,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(
            color: AppColors.thinGrey,
            width: 0.5,
          )));
}
