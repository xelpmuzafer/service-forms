// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '/config/appColors.dart';

Center customProgressIndicator() {
  return const Center(
    child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor:
            AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor)),
  );
}
