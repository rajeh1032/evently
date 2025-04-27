import 'package:evently/ui/home/tabs/favouraite_tab/favouraite_tab.dart';
import 'package:evently/ui/home/tabs/home_tab/add_event.dart';
import 'package:evently/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/home/tabs/map_tab/map_tab.dart';
import 'package:evently/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavouraiteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.transparentColor,
          ),
          child: BottomAppBar(
            
            padding: EdgeInsets.zero,
            color: Theme.of(context).primaryColor,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              currentIndex: selected,
           
              onTap: (value) {
                setState(() {
                  selected = value;
                });
              },
              // backgroundColor: AppColors.primaryLight,
              // type: BottomNavigationBarType.fixed,
              items: [
                buildBottomNavigationItem(
                    index: 0,
                    SelectediconName: AppAsset.homeIconSelcted,
                    unSelectedIconName: AppAsset.homeIconUnSelcted,
                    labelName: AppLocalizations.of(context)!.home),
                buildBottomNavigationItem(
                    index: 1,
                    SelectediconName: AppAsset.mapIconSelcted,
                    unSelectedIconName: AppAsset.mapIconUnSelcted,
                    labelName: AppLocalizations.of(context)!.map),
                buildBottomNavigationItem(
                    index: 2,
                    SelectediconName: AppAsset.heartIconSelcted,
                    unSelectedIconName: AppAsset.heartIconUnSelcted,
                    labelName: AppLocalizations.of(context)!.favourite),
                buildBottomNavigationItem(
                    index: 3,
                    SelectediconName: AppAsset.profileIconSelcted,
                    unSelectedIconName: AppAsset.profileIconUnSelcted,
                    labelName: AppLocalizations.of(context)!.profile)
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo add event
          Navigator.pushNamed(context, AddEvent.routeName);
        },
        child: const Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selected],
    );
  }

  BottomNavigationBarItem buildBottomNavigationItem(
      {required String unSelectedIconName,
      required String labelName,
      required String SelectediconName,
      required int index}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(
            selected == index ? SelectediconName : unSelectedIconName,
          ),
        ),
        label: labelName);
  }
}
