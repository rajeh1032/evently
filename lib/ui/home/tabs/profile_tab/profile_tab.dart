import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/tabs/profile_tab/languge_bottom_sheet%20copy.dart';
import 'package:evently/ui/home/tabs/profile_tab/theme_bottom_sheet.dart';
import 'package:evently/utils/app_asset.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.18,
        backgroundColor: AppColors.primaryLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
          ),
        ),
        title: Row(
          children: [
            Image.asset("assets/images/route_image.png"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ahmed Rajeh", style: AppStyles.bold20White),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Text(
                      "ahmed@gmail.com",
                      style: AppStyles.bold16White,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            GestureDetector(
              onTap: () {
                showLanguageButtonSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: height * 0.019),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.currentLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyles.bold20Primary,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.006,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            GestureDetector(
              onTap: () {
                showThemeButtonSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: height * 0.019),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.currentTheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: AppStyles.bold20Primary,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.050),
              child: ElevatedButton(
                onPressed: () {
                  //todo Logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    const ImageIcon(
                      AssetImage(AppAsset.logoutIcon),
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.logout,
                      style: AppStyles.bold20White,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showLanguageButtonSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => const LangugeBottomSheet(),
  );
}

void showThemeButtonSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => const ThemeBottomSheet(),
  );
}
/*
 h=841
 w=393

  */