import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.03),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
            onTap: () {
              //todo change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.currentTheme == ThemeMode.dark
                ? selctedItem(AppLocalizations.of(context)!.dark)
                : unSelctedItem(AppLocalizations.of(context)!.dark)),
        SizedBox(
          height: height * 0.019,
        ),
        InkWell(
            onTap: () {
              //todo change Theme to light
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: themeProvider.currentTheme == ThemeMode.light
                ? selctedItem(AppLocalizations.of(context)!.light)
                : unSelctedItem(AppLocalizations.of(context)!.light)),
      ]),
    );
  }

  Widget selctedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: AppColors.primaryLight),
        ),
        const Icon(
          Icons.check,
          size: 35,
          color: AppColors.primaryLight,
        )
      ],
    );
  }

  Widget unSelctedItem(String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(color: AppColors.blackColor),
    );
  }
}
