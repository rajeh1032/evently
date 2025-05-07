import 'package:evently/model/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/event_details.dart';
import 'package:evently/ui/home/tabs/home_tab/event_item.dart';
import 'package:evently/ui/widget/custom_text_field.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavouraiteTab extends StatefulWidget {
  FavouraiteTab({super.key});

  @override
  State<FavouraiteTab> createState() => _FavouraiteTabState();
}

class _FavouraiteTabState extends State<FavouraiteTab> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    /// تأكد من تحميل بيانات المفضلة أولًا
    if (eventProvider.favoriteEventList.isEmpty) {
      setState(() {
        filterFavoiriteEvent = eventProvider.favoriteEventList;
      });
    } else {
      filterFavoiriteEvent = eventProvider.favoriteEventList;
    }
  }

  var filterFavoiriteEvent = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);
    // eventListProvider.getAllEvent(userProvider.user!.id);

    // if (eventListProvider.favoriteEventList.isEmpty) {
    //   eventListProvider.getAllIsFavorite(userProvider.user!.id);
    // }
    return Column(
      children: [
        SizedBox(
          height: height * 0.08,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          //todo search event favorite
          child: CustomTextField(
            borderColor: AppColors.primaryLight,
            prefixIcon: ImageIcon(
              AssetImage(AppAsset.searchIcon),
              color: AppColors.primaryLight,
            ),
            hintText: AppLocalizations.of(context)!.search_event,
            hintStyle: AppStyles.bold16Primary,
            onChanged: (newText) {
              searchedFavoriteEvent(newText);
            },
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        //todo show favorite event
        Expanded(
          child: filterFavoiriteEvent.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_event_added,
                    style: AppStyles.bold20Primary,
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.only(top: height * 0.01),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: height * 0.013,
                    );
                  },
                  itemCount: filterFavoiriteEvent.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          EventDetails.routeName,
                          arguments: filterFavoiriteEvent[index],
                        );
                      },
                      child: EventItem(
                        event: filterFavoiriteEvent[index],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void searchedFavoriteEvent(String newText) {
    var eventListProvider = Provider.of<EventProvider>(context, listen: false);
    setState(() {
      filterFavoiriteEvent = eventListProvider.favoriteEventList
          .where((event) =>
              event.title.toLowerCase().contains(newText.toLowerCase()))
          .toList();
    });
  }
}
