import 'package:evently/providers/language_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LangugeBottomSheet extends StatefulWidget {
  const LangugeBottomSheet({super.key});

  @override
  State<LangugeBottomSheet> createState() => _LangugeBottomSheetState();
}

class _LangugeBottomSheetState extends State<LangugeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var provider = Provider.of<LanguageProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.03),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
            onTap: () {
              //todo change Language to en
              provider.changeLangauge('en');
            },
            child: provider.currentLanguage == 'en'
                ? selctedItem(AppLocalizations.of(context)!.english)
                : unSelctedItem(AppLocalizations.of(context)!.english)),
        SizedBox(
          height: height * 0.019,
        ),
        InkWell(
            onTap: () {
              //todo change Language
              provider.changeLangauge('ar');
            },
            child: provider.currentLanguage == 'ar'
                ? selctedItem(AppLocalizations.of(context)!.arabic)
                : unSelctedItem(AppLocalizations.of(context)!.arabic)),
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
        Icon(
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
