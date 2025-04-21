import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomLocationButton extends StatelessWidget {
  String firstText;
  String? secondText;
  String leadingIconImage;
  bool? suffixIcon;
  VoidCallback? onTap;
  CustomLocationButton({
    required this.firstText,
    this.secondText,
    required this.leadingIconImage,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        height: height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryLight, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.017,
            ),
            Container(
              padding: EdgeInsets.all(width * 0.029),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryLight, width: 1),
              ),
              child: ImageIcon(
                AssetImage(leadingIconImage),
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(
              width: width * 0.030,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstText,
                  style: AppStyles.medium16Primary,
                ),
                Text(
                  secondText ?? "",
                  style: AppStyles.medium16Black,
                ),
              ],
            ),
            const Spacer(),
            suffixIcon == true
                ? Icon(
                    Icons.arrow_right,
                    color: AppColors.primaryLight,
                    size: 40,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
