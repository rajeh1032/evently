import 'package:evently/ui/home/tabs/home_tab/event_item.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouraiteTab extends StatelessWidget {
  const FavouraiteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.08,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: CustomTextField(
            borderColor: AppColors.primaryLight,
            prefixIcon: ImageIcon(
              AssetImage(AppAsset.searchIcon),
              color: AppColors.primaryLight,
            ),
            hintText: AppLocalizations.of(context)!.search_event,
            hintStyle: AppStyles.bold16Primary,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: height * 0.013,
              );
            },
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              // return EventItem();
            },
          ),
        ),
      ],
    );
  }
}
