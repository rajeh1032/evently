import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.030),
      height: height * 0.31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 1),
        image: DecorationImage(
          image: AssetImage(AppAsset.sportBG),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: height * 0.0095, horizontal: width * 0.018),
            width: width * 0.11,
            height: height * 0.065,
            decoration: BoxDecoration(
              color: AppColors.whiteBgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyColor, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "21",
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  "Nov",
                  style: AppStyles.bold16Primary,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: height * 0.0095, horizontal: width * 0.018),
            width: double.infinity,
            height: height * 0.065,
            decoration: BoxDecoration(
              color: AppColors.whiteBgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyColor, width: 1),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.018,
                ),
                Text(
                  "This is Birthday Party",
                  style: AppStyles.medium16Black,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    //todo add to favourite
                  },
                  icon: ImageIcon(
                    AssetImage(AppAsset.heartIconUnSelcted),
                  ),
                  color: AppColors.primaryLight,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
