import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventTab extends StatelessWidget {
  EventTab(
      {required this.eventName,
      required this.eventIcon,
      required this.isSelected,
      required this.selectedBackgroundColor,
      required this.selectedTextIconColor,
      required this.unSelectedTextIconColor,
      this.broderColor});
  String eventName;
  IconData eventIcon;
  final bool isSelected;
  Color? selectedBackgroundColor;
  Color? selectedTextIconColor;
  Color? unSelectedTextIconColor;
  Color? broderColor;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: height * 0.0475,
      decoration: BoxDecoration(
          color:
              isSelected ? selectedBackgroundColor : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: broderColor ?? AppColors.whiteColor, width: 2)),
      child: Row(
        children: [
          Icon(
            eventIcon,
            color: isSelected ? selectedTextIconColor : unSelectedTextIconColor,
          ),
          SizedBox(
            width: width * 0.020,
          ),
          Text(
            eventName,
            style: AppStyles.bold16Primary.copyWith(
              color:
                  isSelected ? selectedTextIconColor : unSelectedTextIconColor,
            ),
          )
        ],
      ),
    );
  }
}
