import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
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
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    var langaugeProvider = Provider.of<LanguageProvider>(context);
    final isEnglish = langaugeProvider.currentLanguage == "en";
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.currentTheme == ThemeMode.dark;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> eventsNameIcon = [
      {
        "name": AppLocalizations.of(context)!.all,
        "icon": Bootstrap.list,
      },
      {
        "name": AppLocalizations.of(context)!.sport,
        "icon": Bootstrap.balloon,
      },
      {
        "name": AppLocalizations.of(context)!.birthday,
        "icon": Bootstrap.gift,
      },
      {
        "name": AppLocalizations.of(context)!.meeting,
        "icon": Bootstrap.people,
      },
      {
        "name": AppLocalizations.of(context)!.gaming,
        "icon": Bootstrap.controller,
      },
      {
        "name": AppLocalizations.of(context)!.workshop,
        "icon": Bootstrap.tools,
      },
      {
        "name": AppLocalizations.of(context)!.book_club,
        "icon": Bootstrap.book,
      },
      {
        "name": AppLocalizations.of(context)!.exhibition,
        "icon": Bootstrap.image,
      },
      {
        "name": AppLocalizations.of(context)!.holiday,
        "icon": Bootstrap.sun,
      },
      {
        "name": AppLocalizations.of(context)!.eating,
        "icon": Bootstrap.egg_fried,
      },
    ];
    var eventListProvider = Provider.of<EventProvider>(context);
    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvent();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)!.primaryColor,
        title: Row(
          children: [
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.medium16White,
                ),
                Text(
                  "Ahmed Rajeh",
                  style: AppStyles.bold20White,
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                //todo change theme
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
                //todo change Langauge
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
            )
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
                    length: eventsNameIcon.length,
                    child: TabBar(
                      onTap: (index) {
                        setState(() {
                          selected = index;
                        });
                      },
                      isScrollable: true,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.transparentColor,
                      dividerColor: AppColors.transparentColor,
                      tabAlignment: TabAlignment.start,
                      tabs: eventsNameIcon.asMap().entries.map(
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
                              isSelected: selected == index ? true : false);
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: height * 0.01 ),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: height * 0.013,
                );
              },
              itemCount: eventListProvider.eventList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EventDetails.routeName);
                    },
                    child: EventItem(
                      event: eventListProvider.eventList[index],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
