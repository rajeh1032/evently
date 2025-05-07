import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/current_event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/edit_even.dart';
import 'package:evently/ui/home/tabs/home_tab/event_details.dart';
import 'package:evently/ui/home/tabs/home_tab/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/event_tab.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    var langaugeProvider = Provider.of<LanguageProvider>(context);
    final isEnglish = langaugeProvider.currentLanguage == "en";
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.currentTheme == ThemeMode.dark;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var eventListProvider = Provider.of<EventProvider>(context);
    if (eventListProvider.filterList.isEmpty) {
      eventListProvider.getAllEventFilter(context, userProvider.user!.id);
    }
    eventListProvider.geteventsNameIcon(context);
    var currentEventProvider = Provider.of<CurrentEvent>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Changed from start to spaceBetween
          children: [
            Expanded(
              // Wrap the title in Expanded to control its alignment
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // This ensures text aligns to the start
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: AppStyles.medium16White,
                  ),
                  Text(
                    userProvider.user!.name,
                    style: AppStyles.bold20White,
                  ),
                ],
              ),
            ),
            // No need for Spacer() when using MainAxisAlignment.spaceBetween
            Row(
              // Group the icons in their own Row
              children: [
                IconButton(
                  onPressed: () {
                    // Change theme
                    isDark
                        ? themeProvider.changeTheme(ThemeMode.light)
                        : themeProvider.changeTheme(ThemeMode.dark);
                  },
                  icon: ImageIcon(
                    AssetImage(
                      AppAsset.sunIcon,
                    ),
                    color: AppColors.whiteColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Change Language
                    isEnglish
                        ? langaugeProvider.changeLangauge("ar")
                        : langaugeProvider.changeLangauge("en");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.whiteColor,
                    ),
                    child: Text(isEnglish ? "عربي" : "EN",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.044, vertical: height * 0.0095),
            height: height * 0.13,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Column(
              children: [
                Row(
                  children: [
                    const ImageIcon(
                      AssetImage(AppAsset.mapIconUnSelcted),
                      color: AppColors.whiteColor,
                    ),
                    Text(
                      "Cairo , Egypt",
                      style: AppStyles.medium14White,
                    )
                  ],
                ),
                Expanded(
                  child: DefaultTabController(
                    length: eventListProvider.eventsNameIcon.length,
                    child: TabBar(
                      onTap: (index) {
                        setState(() {
                          eventListProvider.changeSelectdIndex(
                              index, userProvider.user!.id, context);
                        });
                      },
                      isScrollable: true,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.transparentColor,
                      dividerColor: AppColors.transparentColor,
                      tabAlignment: TabAlignment.start,
                      tabs:
                          eventListProvider.eventsNameIcon.asMap().entries.map(
                        (entry) {
                          int index = entry.key;
                          var event = entry.value;
                          return EventTab(
                              selectedTextIconColor:
                                  Theme.of(context).hintColor,
                              unSelectedTextIconColor: AppColors.whiteColor,
                              selectedBackgroundColor:
                                  Theme.of(context).focusColor,
                              eventName: event['name'],
                              eventIcon: event['icon'],
                              isSelected:
                                  eventListProvider.selectedIndex == index
                                      ? true
                                      : false);
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
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
                    itemCount: eventListProvider.filterList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, EventDetails.routeName);
                            currentEventProvider.setCurrentEvent(
                                eventListProvider.filterList[index]);
                          },
                          child: EventItem(
                            event: eventListProvider.filterList[index],
                          ));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
