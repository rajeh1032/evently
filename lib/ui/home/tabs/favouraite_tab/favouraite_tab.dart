import 'package:evently/providers/event_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/event_item.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavouraiteTab extends StatefulWidget {
  const FavouraiteTab({super.key});

  @override
  State<FavouraiteTab> createState() => _FavouraiteTabState();
}

class _FavouraiteTabState extends State<FavouraiteTab> {
  @override
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventProvider>(context);
    eventListProvider.getAllIsFavorite(); // نداء دائم
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
          child: eventListProvider.favoriteEventList.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_event_added,
                    style: AppStyles.bold20Primary,
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: height * 0.013,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return EventItem(
                        event: eventListProvider.favoriteEventList[index]);
                  },
                  itemCount: eventListProvider.favoriteEventList.length,
                ),
        ),
      ],
    );
  }
}
