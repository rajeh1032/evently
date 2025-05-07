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
  // void initState() {
  //   super.initState();
  //   // Defer the loading to after the first frame
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _loadFavorites();
  //   });
  // }
  // ///to solve exception
  // bool isLoading = true;
  // Future<void> _loadFavorites() async {
  //   if (!mounted) return;

  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   final eventListProvider =
  //       Provider.of<EventProvider>(context, listen: false);

  //   if (userProvider.user != null) {
  //     eventListProvider.getAllIsFavorite(userProvider.user!.id);
  //   }

  //   if (mounted) {
  //     setState(() => isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);
    // eventListProvider.getAllEvent(userProvider.user!.id);

    var eventListProvider = Provider.of<EventProvider>(context);
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
          child: eventListProvider.filterList.isEmpty
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
                  itemCount: eventListProvider.favoriteEventList.length,
                  itemBuilder: (context, index) {
                    return EventItem(
                      event: eventListProvider.favoriteEventList[index],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
