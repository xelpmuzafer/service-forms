// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/config/appColors.dart';
import '/config/textStyles.dart';

class CustomAppBar extends StatelessWidget {
  final String ? suffixTitle;
  const CustomAppBar({
    Key? key,  this.suffixTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                          //back  button
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 22,
                              color: AppColors.black,
                            ),
                            SizedBox(width: 5,),
                          Text("Back",
                              style: h4BlackSemiBold.copyWith(
                                color: AppColors.black,
                              ))
                        ],
                      ),
                    ),

 //title
 Text(suffixTitle ??"",
                            style: h4BlackSemiBold.copyWith(
                              color: AppColors.black,
                            ))




        ],
      ),
    );
  }
}
