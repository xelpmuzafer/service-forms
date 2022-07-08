// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import '/config/appColors.dart';
import '/widgets/customButton.dart';
import '/widgets/serachBarWidget.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmerEffect extends StatelessWidget {
  const DashboardShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   
          Container(
        
            decoration: BoxDecoration(
                            
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(27),
                                  topRight: Radius.circular(27)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.2),
                                  spreadRadius: 10,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 7), // changes position of shadow
                                ),
                              ],
                              color: AppColors.white),
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                 

                  Expanded(
                    child: ListView(
                    padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                      children: [
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor: AppColors.lightGreyBg,
                                      highlightColor: AppColors.cardBg,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                width: 120,
                                decoration:
                                    const BoxDecoration(color: AppColors.cardBg),
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 0.9),
                            itemCount: 11,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 30),
                            itemBuilder: (context, index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //image
                                    Shimmer.fromColors(
                                      baseColor: AppColors.lightGreyBg,
                                      highlightColor: AppColors.cardBg,
                                      child: Container(
                                        // padding: EdgeInsets.all(8),
                                        height: 56,
                                        width: 56,
                                        margin:
                                            const EdgeInsets.symmetric(vertical: 10),

                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.cardBg),
                                        child: Image.asset(
                                            "assets/images/services/marriage-certificate.png"),
                                      ),
                                    ),

                                    Flexible(
                                        child: Shimmer.fromColors(
                                         baseColor: AppColors.lightGreyBg,
                                      highlightColor: AppColors.cardBg,
                                      child: Container(
                                        color: AppColors.white,
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        height: 20,
                                        
                                      ),
                                    ))
                                  ],
                                )),
                        Shimmer.fromColors(
                             baseColor: AppColors.lightGreyBg,
                                      highlightColor: AppColors.cardBg,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: CustomElevatedButton.elevatedButton(
                                onPressed: () {}, title: ""),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
   
   
    
  }
}